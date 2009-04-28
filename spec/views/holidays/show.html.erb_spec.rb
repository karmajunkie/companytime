require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/holidays/show.html.erb" do
  include HolidaysHelper
  before(:each) do
    assigns[:holiday] = @holiday = stub_model(Holiday,
      :name => "value for name",
      :optional => false
    )
  end

  it "renders attributes in <p>" do
    render
    response.should have_text(/value\ for\ name/)
    response.should have_text(/false/)
  end
end

