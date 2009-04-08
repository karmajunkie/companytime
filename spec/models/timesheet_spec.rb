require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Timesheet do
  before(:each) do
    @valid_attributes = {
      :user_id => 1,
      :start_date => Date.new(2009, 3,1),
      :end_date => Date.new(2009,3,31)
    }
  end

  it "should create a new instance given valid attributes" do
    Timesheet.create!(@valid_attributes)
  end
  it "should create pto_allocations for each date it covers" do
    t=Timesheet.create!(@valid_attributes)
    t.pto_allocations.size.should == 31
  end
  it "should create an accrual object when it gets created" do
    t=Timesheet.create!(@valid_attributes)
    t.save
    t.accrual.should_not be_nil
  end
  it "should only allow one timesheet per user per month" do
    t1=Timesheet.create!(@valid_attributes)
    t1.save
    t2=Timesheet.create(@valid_attributes)
    t2.errors.should_not be_empty
  end
end
