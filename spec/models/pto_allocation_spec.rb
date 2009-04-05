require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PtoAllocation do
  before(:each) do
    @valid_attributes = {
      :timesheet_id => 1,
      :allocation_date => Time.now,
      :sick => 1.5,
      :vacation => 1.5,
      :holiday => 1.5
    }
  end

  it "should create a new instance given valid attributes" do
    PtoAllocation.create!(@valid_attributes)
  end
end
