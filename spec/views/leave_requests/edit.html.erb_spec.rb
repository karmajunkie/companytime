require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/leave_requests/edit.html.erb" do
  include LeaveRequestsHelper
  
  before(:each) do
    assigns[:leave_request] = @leave_request = stub_model(LeaveRequest,
      :new_record? => false,
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
  end

  it "renders the edit leave_request form" do
    render
    
    response.should have_tag("form[action=#{leave_request_path(@leave_request)}][method=post]") do
      with_tag('input#leave_request_leave_period_id[name=?]', "leave_request[leave_period_id]")
      with_tag('textarea#leave_request_reason[name=?]', "leave_request[reason]")
      with_tag('input#leave_request_vacation_hours[name=?]', "leave_request[vacation_hours]")
      with_tag('input#leave_request_holiday_hours[name=?]', "leave_request[holiday_hours]")
      with_tag('input#leave_request_sick_hours[name=?]', "leave_request[sick_hours]")
      with_tag('input#leave_request_bereavement[name=?]', "leave_request[bereavement]")
      with_tag('input#leave_request_bereavement_hours[name=?]', "leave_request[bereavement_hours]")
      with_tag('input#leave_request_military[name=?]', "leave_request[military]")
      with_tag('input#leave_request_military_hours[name=?]', "leave_request[military_hours]")
      with_tag('input#leave_request_comp_hours[name=?]', "leave_request[comp_hours]")
      with_tag('input#leave_request_jury_duty[name=?]', "leave_request[jury_duty]")
      with_tag('input#leave_request_jury_hours[name=?]', "leave_request[jury_hours]")
      with_tag('input#leave_request_unpaid[name=?]', "leave_request[unpaid]")
      with_tag('input#leave_request_unpaid_hours[name=?]', "leave_request[unpaid_hours]")
      with_tag('input#leave_request_administrative[name=?]', "leave_request[administrative]")
      with_tag('input#leave_request_administrative_hours[name=?]', "leave_request[administrative_hours]")
    end
  end
end


