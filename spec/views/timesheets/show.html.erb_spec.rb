require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/timesheets/show.html.erb" do
  include TimesheetsHelper
  before(:each) do
    assigns[:timesheet] = @timesheet = stubbed_timesheet
  end

  it "renders attributes in <p>" do
    render
  end
end

