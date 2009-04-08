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
    @timesheet = Timesheet.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @timesheet }
    end
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
    @timesheet = Timesheet.find(params[:id])
    #@user = @timesheet.user
    @comp_accumulated=0
    @month_total_hours=0
    @month_expected_hours=160 #days 1-28 always have 160 work hours in them
    (@timesheet.start_date.to_date+28).upto @timesheet.end_date.to_date do |d|
      @month_expected_hours+=8 if d.cwday <= 5
    end
    @hour_totals=@timesheet.user.work_periods.for_month(@timesheet.start_date).total_hours.map!{ |wkday| 
      @comp_accumulated += (wkday.total_hours.to_f-8) if wkday.total_hours.to_f > 8
      @month_total_hours+=wkday.total_hours.to_f
      [wkday.total_hours.to_f, wkday.date_worked]
    }
  end

  # POST /timesheets
  # POST /timesheets.xml
  def create
    #sdate=Date.new params[:start_date]['year'].to_i, params[:start_date]['month'].to_i, params[:start_date]['day'].to_i
    @user = User.find_by_login(params[:user_login])
    #debugger
    @timesheet=Timesheet.new(params[:timesheet])
    if @user 
      #@timesheet.start_date=sdate.beginning_of_month
      @timesheet.end_date=@timesheet.start_date.end_of_month

    end
    respond_to do |format|
      if @timesheet.save
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
end
