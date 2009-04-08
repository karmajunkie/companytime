require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/timesheets/index.html.erb" do
  include TimesheetsHelper
  
  before(:each) do
    assigns[:timesheets] = [
      stub_model(Timesheet),
      stub_model(Timesheet)
    ]
  end

  it "renders a list of timesheets" do
    render
  end
end

