require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/holidays/index.html.erb" do
  include HolidaysHelper
  
  before(:each) do
    assigns[:holidays] = [
      stub_model(Holiday,
        :name => "value for name",
        :optional => false
      ),
      stub_model(Holiday,
        :name => "value for name",
        :optional => false
      )
    ]
  end

  it "renders a list of holidays" do
    render
    response.should have_tag("tr>td", "value for name".to_s, 2)
    response.should have_tag("tr>td", false.to_s, 2)
  end
end

