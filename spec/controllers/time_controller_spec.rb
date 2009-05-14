require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe TimeController do

  #Delete these examples and add some real ones
  it "should use TimeController" do
    controller.should be_an_instance_of(TimeController)
  end


  describe "GET 'edit'" do
    it "should be successful" do
      get 'edit'
      response.should be_success
    end
  end

  describe "GET 'destroy'" do
    it "should be successful" do
      get 'destroy'
      response.should be_success
    end
  end

  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      response.should be_success
    end
  end
end
