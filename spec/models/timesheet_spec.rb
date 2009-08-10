require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Timesheet do
  before(:each) do
    @ts = Factory(:timesheet)
  end

  describe "validations" do
	  it "should be valid" do
		  @ts.should be_valid
	  end
	  it "should not be valid without a user" do
		  @ts.user = nil
		  @ts.should_not be_valid
	  end
	  it "should not be valid without a start date" do
		  @ts.start_date = nil
		  @ts.should_not be_valid
	  end
	  it "should not be valid without an end date" do
		  @ts.end_date = nil
		  @ts.should_not be_valid
	  end
	  it "should not be valid with a duplicate start date for the user" do
		  ts2=Factory.build(:timesheet, :user => @ts.user, :start_date => @ts.start_date)
		  ts2.should_not be_valid
	  end
  end
  it "should create pto_allocations for each date it covers" do
    t=Factory(:timesheet)
    t.pto_allocations.size.should == (t.end_date.to_date-t.start_date.to_date)+1
  end
  it "should create a starting accrual object when it gets created" do
    t=Factory(:timesheet)
    t.starting_accrual.should_not be_nil
  end
  it "should create a properly incremented ending accrual object upon creation" do
    t=Factory(:timesheet)
    t.ending_accrual.should_not be_nil
    t.ending_accrual.vacation_hours.should == t.starting_accrual.vacation_hours+t.user.vacation_accrual_rate
  end
  it "should credit holiday hours at the beginning of the month" do
	  h=Factory(:holiday)
	  t=Factory(:timesheet)
		t.ending_accrual.holiday_hours.should == 8	  
  end

end
