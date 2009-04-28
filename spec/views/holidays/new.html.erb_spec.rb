require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/holidays/new.html.erb" do
  include HolidaysHelper
  
  before(:each) do
    assigns[:holiday] = stub_model(Holiday,
      :new_record? => true,
      :name => "value for name",
      :optional => false
    )
  end

  it "renders new holiday form" do
    render
    
    response.should have_tag("form[action=?][method=post]", holidays_path) do
      with_tag("input#holiday_name[name=?]", "holiday[name]")
      with_tag("input#holiday_optional[name=?]", "holiday[optional]")
    end
  end
end


