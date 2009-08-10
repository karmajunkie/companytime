class  AdminController < ApplicationController
  layout "application"
  def index
    @pending_leave_requests=LeaveRequest.pending
  end

end
	