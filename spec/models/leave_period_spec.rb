require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe LeavePeriod do
	describe "validations" do
		before(:each) do
      @lp=Factory(:leave_period)
		end
		it "should be valid" do
			@lp.should be_valid
		end
#		it "should not be valid without a leave request" do
#			@lp.leave_request=nil
#			@lp.should_not be_valid
#		end
	end


end
