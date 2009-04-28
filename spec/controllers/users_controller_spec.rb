require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe UsersController do
  fixtures(:users)
  describe "POST clockin" do
    it "should create a new WorkPeriod for the user" do
      user=users(:keith)
      
    end
    it "should not allow a clockin unless the user is clocked out"
  end
  describe "POST clockout" do
    it "should modify the user's last WorkPeriod"
    it "should not allow a clockout unless the user is clocked in"
  end
  describe "GET clockin or out" do
    it "should respond with an error code to a GET request"
  end
end


