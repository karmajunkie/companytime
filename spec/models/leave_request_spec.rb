require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe LeaveRequest do
  before(:each) do
    @valid_attributes = {
      :leave_period_id => 1,
      :reason => "value for reason",
      :vacation_hours => 1.5,
      :holiday_hours => 1.5,
      :sick_hours => 1.5,
      :bereavement => false,
      :bereavement_hours => 1.5,
      :military => false,
      :military_hours => 1.5,
      :comp_hours => 1.5,
      :jury_duty => false,
      :jury_hours => 1.5,
      :unpaid => false,
      :unpaid_hours => 1.5,
      :administrative => false,
      :administrative_hours => 1.5
    }
  end

  it "should create a new instance given valid attributes" do
    LeaveRequest.create!(@valid_attributes)
  end
end
