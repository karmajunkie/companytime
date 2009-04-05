
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
end
