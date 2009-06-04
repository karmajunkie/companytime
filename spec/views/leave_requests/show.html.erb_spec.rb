require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/leave_requests/show.html.erb" do
  include LeaveRequestsHelper
  before(:each) do
    assigns[:leave_request] = @leave_request = stub_model(LeaveRequest,
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
  end

  it "renders attributes in <p>" do
    render
    response.should have_text(/1/)
    response.should have_text(/value\ for\ reason/)
    response.should have_text(/1\.5/)
    response.should have_text(/1\.5/)
    response.should have_text(/1\.5/)
    response.should have_text(/false/)
    response.should have_text(/1\.5/)
    response.should have_text(/false/)
    response.should have_text(/1\.5/)
    response.should have_text(/1\.5/)
    response.should have_text(/false/)
    response.should have_text(/1\.5/)
    response.should have_text(/false/)
    response.should have_text(/1\.5/)
    response.should have_text(/false/)
    response.should have_text(/1\.5/)
  end
end

