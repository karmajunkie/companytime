class  AdminController < ApplicationController
  layout "application"
  def index
	  @admin = true
    @open_leave_requests=LeaveRequest.open
  end

end
	