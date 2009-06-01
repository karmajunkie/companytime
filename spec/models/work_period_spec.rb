
require File.dirname(__FILE__) + '/../spec_helper'

describe WorkPeriod do
  it "calculates hours for a complete work period" do
    work_period = WorkPeriod.new
    work_period.start_time = (8.75.hours.ago ).to_datetime
    work_period.end_time = 1.hours.ago.to_datetime

    work_period.hours.should == 7.75
  end
  
  it "calculates time since a clock-in when not clocked out" do
    work_period = WorkPeriod.new
    work_period.start_time = (8.75.hours.ago ).to_datetime

    work_period.hours.should == 8.75
  end
  
  describe "validating if clocked in" do
    it "should be invalid when user is clocked in and start_time is after current clock-in time" do
      open_work_period = Factory(:work_period, :end_time => nil)
      work_period = Factory.build(:work_period, :user => open_work_period.user)
      work_period.should_not be_valid
      work_period.errors.on_base.should_not be_nil
    end
    it "should be valid if user is clocked in and adding a new work_period before current one" do
      open_work_period = Factory(:work_period, :end_time => nil)
      open_start=open_work_period.start_time
      work_period = Factory.build(:work_period, :start_time => 3.days.ago, :end_time => 2.days.ago)
      work_period.should be_valid 
    end
    it "should not overlap with any other work periods"
    it "should be valid when user is not clocked in" do
      Factory.build(:work_period, :end_time => nil).should be_valid
    end
    
    it "should be valid when another user is clocked in" do
      user1 = Factory(:user)
      user2 = Factory(:user)
      open_work_period = Factory(:work_period, :end_time => nil, :user => user1)
      work_period = Factory.build(:work_period, :end_time => nil, :user => user2)
      work_period.should be_valid
    end
  end
end
