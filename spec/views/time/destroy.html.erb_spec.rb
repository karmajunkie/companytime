require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/time/destroy" do
  before(:each) do
    render 'time/destroy'
  end
  
  #Delete this example and add some real ones or delete this file
  it "should tell you where to find the file" do
    response.should have_tag('p', %r[Find me in app/views/time/destroy])
  end
end