require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe LeaveRequest do
  before(:each) do
    @leave_request=Factory(:leave_request)
  end
	describe "validations" do
		it "should be valid" do
			@leave_request.should be_valid
		end
		it "should not be valid without an employee" do
			@leave_request.employee = nil
			@leave_request.should_not be_valid
		end
	end
end
