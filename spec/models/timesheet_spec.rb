require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Timesheet do
  fixtures(:users)
  before(:each) do
    kg=users(:keith)
    @valid_attributes = {
      :user_id => kg.id,
      :start_date => 1.month.ago.beginning_of_month,
      :end_date => 1.month.ago.end_of_month
    }
  end

  it "should create a new instance given valid attributes" do
    Timesheet.create!(@valid_attributes)
  end
  it "should create pto_allocations for each date it covers" do
    t=Timesheet.create!(@valid_attributes)
    t.pto_allocations.size.should == 31
  end
  it "should create a starting accrual object when it gets created" do
    t=Timesheet.create!(@valid_attributes)
    t.save
    t.starting_accrual.should_not be_nil
  end
  it "should create a properly incremented ending accrual object upon creation" do
    t=Timesheet.create!(@valid_attributes)
    t.save
    t.ending_accrual.should_not be_nil
    t.ending_accrual.vacation_hours.should == t.starting_accrual.vacation_hours+t.user.vacation_accrual_rate
  end
  it "should credit holiday hours at the beginning of the month"
  it "should only allow one timesheet per user per month" do
    t1=Timesheet.create!(@valid_attributes)
    t1.save
    t2=Timesheet.create(@valid_attributes)
    t2.errors.should_not be_empty
  end
end
