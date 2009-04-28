require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Accrual do
  before(:each) do
    @valid_attributes = {
      :vacation_hours => 1.5,
      :holiday_hours => 1.5,
      :sick_hours => 1.5,
      :timesheet_id => 1
    }
  end

  it "should create a new instance given valid attributes" do
    Accrual.create!(@valid_attributes)
  end
end
