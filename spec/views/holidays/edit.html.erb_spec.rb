require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/holidays/edit.html.erb" do
  include HolidaysHelper
  
  before(:each) do
    assigns[:holiday] = @holiday = stub_model(Holiday,
      :new_record? => false,
      :name => "value for name",
      :optional => false
    )
  end

  it "renders the edit holiday form" do
    render
    
    response.should have_tag("form[action=#{holiday_path(@holiday)}][method=post]") do
      with_tag('input#holiday_name[name=?]', "holiday[name]")
      with_tag('input#holiday_optional[name=?]', "holiday[optional]")
    end
  end
end


