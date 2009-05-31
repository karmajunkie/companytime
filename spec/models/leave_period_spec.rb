require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe LeavePeriod do
  before(:each) do
    @valid_attributes = {
      :from_date => Date.today,
      :until_date => Date.today,
      :leave_request_id => 1,
      :from_time => Time.now,
      :until_time => Time.now
    }
  end

  it "should create a new instance given valid attributes" do
    LeavePeriod.create!(@valid_attributes)
  end
end
