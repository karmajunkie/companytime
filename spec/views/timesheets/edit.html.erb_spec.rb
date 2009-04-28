require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/timesheets/edit.html.erb" do
  include TimesheetsHelper
  
  before(:each) do
    assigns[:timesheet] = @timesheet = stubbed_timesheet
  end

  it "renders the edit timesheet form" #do
    #render
    
    #response.should have_tag("form[action=#{timesheet_path(@timesheet)}][method=post]") do
    #end
  #end
end


