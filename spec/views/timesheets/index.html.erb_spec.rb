require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/timesheets/index.html.erb" do
  include TimesheetsHelper
  
  before(:each) do
    assigns[:timesheets] = [
      stub_model(Timesheet, :start_date => Date.today.beginning_of_month, :end_date => Date.today.end_of_month, :user => stub_model(User, :first_name => "John", :last_name => "Doe")),
      stub_model(Timesheet, :start_date => Date.today.beginning_of_month, :end_date => Date.today.end_of_month, :user => stub_model(User, :first_name => "John", :last_name => "Doe"))
    ]
  end

  it "renders a list of timesheets" do
    render
  end
end

