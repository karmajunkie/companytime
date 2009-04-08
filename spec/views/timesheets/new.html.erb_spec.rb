require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/timesheets/new.html.erb" do
  include TimesheetsHelper
  
  before(:each) do
    assigns[:timesheet] = stub_model(Timesheet,
      :new_record? => true
    )
  end

  it "renders new timesheet form" do
    render
    
    response.should have_tag("form[action=?][method=post]", timesheets_path) do
    end
  end
end


