require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Timesheet do
  before(:each) do
    @valid_attributes = {
      :user_id => 1,
      :accrual_id => 1,
      :period_begin => Time.now,
      :period_end => Time.now
    }
  end

  it "should create a new instance given valid attributes" do
    Timesheet.create!(@valid_attributes)
  end
end
