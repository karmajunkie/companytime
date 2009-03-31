require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe TimesheetController do

  #Delete these examples and add some real ones
  it "should use TimesheetController" do
    controller.should be_an_instance_of(TimesheetController)
  end


  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      response.should be_success
    end
  end

  describe "GET 'generate'" do
    it "should be successful" do
      get 'generate'
      response.should be_success
    end
  end
end
