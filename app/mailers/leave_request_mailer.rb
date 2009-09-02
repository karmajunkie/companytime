class LeaveRequestMailer < ActionMailer::Base
	def leave_request(request)
		subject "Leave request from #{request.employee.email}"
		recipients User.admins.map(&:email)
		body :request => request
	end
end