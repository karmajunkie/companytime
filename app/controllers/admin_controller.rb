class  AdminController < ApplicationController
  layout "application"
  def index
    @open_leave_requests=LeaveRequest.open
  end

end
	