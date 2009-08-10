class LeaveRequestsController < ApplicationController
  # GET /leave_requests
  # GET /leave_requests.xml
  def index
    @leave_requests = LeaveRequest.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @leave_requests }   
    end
  end

  # GET /leave_requests/1
  # GET /leave_requests/1.xml
  def show
    @leave_request = LeaveRequest.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @leave_request }
    end
  end

  # GET /leave_requests/new
  # GET /leave_requests/new.xml
  def new
    @leave_request = LeaveRequest.new
    @new_leave_period = LeavePeriod.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @leave_request }
    end
  end

  # GET /leave_requests/1/edit
  def edit
    @leave_request = LeaveRequest.find(params[:id])
	  @new_leave_period = LeavePeriod.new
  end

  # POST /leave_requests
  # POST /leave_requests.xml
  def create
    @leave_request = current_user.leave_requests.build(params[:leave_request])

    respond_to do |format|
      if @leave_request.save
        flash[:notice] = 'LeaveRequest was successfully created.'
        format.html { redirect_to(current_user) }
        format.xml  { render :xml => @leave_request, :status => :created, :location => @leave_request }
      else
	      debugger
        format.html { render :action => "new" }
        format.xml  { render :xml => @leave_request.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /leave_requests/1
  # PUT /leave_requests/1.xml
  def update
    @leave_request = LeaveRequest.find(params[:id])

    respond_to do |format|
      if @leave_request.update_attributes(params[:leave_request])
        flash[:notice] = 'LeaveRequest was successfully updated.'
        format.html { redirect_to(@leave_request) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @leave_request.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /leave_requests/1
  # DELETE /leave_requests/1.xml
  def destroy
    @leave_request = LeaveRequest.find(params[:id])
    @leave_request.destroy

    respond_to do |format|
      format.html { redirect_to(leave_requests_url) }
      format.xml  { head :ok }
    end
  end

	def approve
		set_approval_status("approved")
	end
	def deny
		set_approval_status("denied")
	end
	private
		def set_approval_status(status)
			@leave_request=LeaveRequest.find(params[:id])
			if !@leave_request.nil?
				@leave_request.approval_code=status
				if @leave_request.save
					render :update do |page|
						page.visual_effect :fade, dom_id(@leave_request)
					end
				else
					render :update do |page|
						page.alert("Error saving the leave request approval")
					end
				end
			end
		end

end
