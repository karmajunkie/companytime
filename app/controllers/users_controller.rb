class UsersController < ApplicationController
	skip_before_filter :login_required, :only => [:clockin, :clockout, :toggle]
  active_scaffold :user
  cache_sweeper :work_period_sweeper, :only => [:toggle, :clockin, :clockout]
  before_filter :admin_required, :only => [:index, :delete]
  before_filter :admin_or_self_required, :only => [:update, :show]

  # GET /users
  # GET /users.xml
  def index
    @users = User.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end

  # GET /users/1
  # GET /users/1.xml
  def show
    @user = User.find(params[:id], :include => [:timesheets, :leave_requests])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/new
  # GET /users/new.xml
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.xml
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        flash[:notice] = 'User was successfully created.'
        format.html { redirect_to(@user) }
        format.xml  { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        flash[:notice] = 'User was successfully updated.'
        format.html { redirect_to(@user) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end

  def accrual_report
    @user = User.find_by_login(params[:id])
    respond_to do |format|
      format.csv { 
        str = FasterCSV.generate do |csv|
          csv << ['login', 'vacation', 'skeleton', 'sick']
          csv << [@user.login, @user.vacation_hours, @user.skeleton_hours, @user.sick_hours]
        end
        render :text => str
      }
      format.html
    end
  end

  def toggle
    if User.find_by_login!(params[:id]).clocked_in?
      puts "logged in"
      clockout
    else
      puts "logged out"
      clockin
    end
  end

  def clockin
    @user = User.find_by_login(params[:id])
    if @user.clocked_in?
      render :text => "You can't log in until you've logged out!", :status => 403
    else
      wp=@user.work_periods.build({:start_time => Time.now})
      wp.save
      respond_to do |format|
        format.js { render :text => "clocked in", :status => 201 }
        format.html{ render :text => 'clocked in' }
      end
      
    end
  end

  def clockout
    @user = User.find_by_login(params[:id])
    if @user.clocked_in?
      wp=@user.work_periods.last
      wp.end_time = Time.now 
      wp.save
      respond_to do |format|
        format.js { render :text => "clocked out", :status => 205 }
        format.html{ render :text => 'clocked out' }
      end
    else
      render :text => "You can't log out until you've logged in!", :status => 403
    end
  end
	def accrual_display
		@user=User.find(params[:id])
		render :partial => "accrued_leave_display", :locals =>{ :user => @user}
	end
end
