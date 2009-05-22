class TimesheetsController < ApplicationController
  # GET /timesheets
  # GET /timesheets.xml
  def index
    @timesheets = Timesheet.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @timesheets }
    end
  end

  # GET /timesheets/1
  # GET /timesheets/1.xml
  def show
    report_prepare(params)
    @show_links = true
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @timesheet }
    end
  end
  def print
    @show_links = false
    report_prepare(params)
    render :action => "show", :layout => "print"
  end

  # GET /timesheets/new
  # GET /timesheets/new.xml
  def new
    @timesheet = Timesheet.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @timesheet }
    end
  end

  # GET /timesheets/1/edit
  def edit
    report_prepare(params)
    update_pto_allocations(@timesheet)
    @user = @timesheet.user
    @comp_accumulated=0
    @month_total_hours=0
    @hour_totals=@timesheet.user.work_periods.for_month(@timesheet.start_date).total_hours(:day).map!{ |wkday| 
      @comp_accumulated += (wkday.total_hours.to_f-8) if wkday.total_hours.to_f > 8
      @month_total_hours+=wkday.total_hours.to_f
      [wkday.total_hours.to_f, wkday.date_worked]
    }
  end

  # POST /timesheets
  # POST /timesheets.xml
  def create
    @user = User.find_by_login(params[:user_login])
    if @user 
      @timesheet=@user.timesheets.build(params[:timesheet]) || Timesheet.new(params[:timesheet])
      @user.save
      @timesheet.end_date=@timesheet.start_date.end_of_month
      #save needs to happen before doing anything with the pto_allocations because they're
      #created in a before_create filter
      @timesheet.save
      update_pto_allocations(@timesheet)
    else
      @timesheet=Timesheet.new(params[:timesheet])
      @timesheet.errors.add("user", "does not exist.")
    end
    respond_to do |format|
      if !@timesheet.new_record?
        flash[:notice] = 'Timesheet was successfully created.'
        format.html { redirect_to(@timesheet) }
        format.xml  { render :xml => @timesheet, :status => :created, :location => @timesheet }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @timesheet.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /timesheets/1
  # PUT /timesheets/1.xml
  def update
    @timesheet = Timesheet.find(params[:id])

    respond_to do |format|
      if @timesheet.update_attributes(params[:timesheet])
        flash[:notice] = 'Timesheet was successfully updated.'
        format.html { redirect_to(@timesheet) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @timesheet.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /timesheets/1
  # DELETE /timesheets/1.xml
  def destroy
    @timesheet = Timesheet.find(params[:id])
    @timesheet.destroy

    respond_to do |format|
      format.html { redirect_to(timesheets_url) }
      format.xml  { head :ok }
    end
  end

  def report
    begin
      @timesheet=Timesheet.find(params[:id])
    rescue ActiveRecord::RecordNotFound
    end
    if @timesheet.nil?
      @timesheets=Timesheet.all
      render :action => :index
    else
      respond_to do |format|
        format.html
        format.xml { render :xml => @timesheet }
      end
    end
  end
  private
    def report_prepare(params)
      @timesheet = Timesheet.find(params[:id])
      @month_expected_hours=160 #days 1-28 always have 160 work hours in them
      (@timesheet.start_date.to_date+28).upto @timesheet.end_date.to_date do |d|
        @month_expected_hours+=8 if d.cwday <= 5
      end
    end
    def update_pto_allocations(timesheet)
      timesheet.pto_allocations.each do |pto|
        if !pto.user_modified?
          #is this right?
          if !timesheet.user.work_periods.for_day(pto.allocation_date).nil?
            hrs=timesheet.user.work_periods.for_day(pto.allocation_date).total_hours(:day)
          else
            hrs=[0]
          end
          if hrs[0]
            pto.comp=0
            pto.holiday=0
            if pto.allocation_date.holiday?
              pto.holiday+=hrs[0].total_hours.to_f
            elsif pto.allocation_date.cwday > 5
              pto.comp+=hrs[0].total_hours.to_f
            elsif hrs[0].total_hours.to_f > 8
              pto.comp+=hrs[0].total_hours.to_f - 8
            end
          end
          pto.save
        end
      end
    end
end
