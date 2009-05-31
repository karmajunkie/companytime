require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/leave_requests/index.html.erb" do
  include LeaveRequestsHelper
  
  before(:each) do
    assigns[:leave_requests] = [
      stub_model(LeaveRequest,
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
      ),
      stub_model(LeaveRequest,
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
      )
    ]
  end

  it "renders a list of leave_requests" do
    render
    response.should have_tag("tr>td", 1.to_s, 2)
    response.should have_tag("tr>td", "value for reason".to_s, 2)
    response.should have_tag("tr>td", 1.5.to_s, 2)
    response.should have_tag("tr>td", 1.5.to_s, 2)
    response.should have_tag("tr>td", 1.5.to_s, 2)
    response.should have_tag("tr>td", false.to_s, 2)
    response.should have_tag("tr>td", 1.5.to_s, 2)
    response.should have_tag("tr>td", false.to_s, 2)
    response.should have_tag("tr>td", 1.5.to_s, 2)
    response.should have_tag("tr>td", 1.5.to_s, 2)
    response.should have_tag("tr>td", false.to_s, 2)
    response.should have_tag("tr>td", 1.5.to_s, 2)
    response.should have_tag("tr>td", false.to_s, 2)
    response.should have_tag("tr>td", 1.5.to_s, 2)
    response.should have_tag("tr>td", false.to_s, 2)
    response.should have_tag("tr>td", 1.5.to_s, 2)
  end
end

