require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe UsersController do
  fixtures(:users)
  describe "GET clockin" do
    it "should return true from user.clocked_in?" do
      user=users(:keith)
      user.clocked_in?.should be_nil
      get :clockin, :id => 'keith'
      user.clocked_in?.should be_true
    end
    it "should not allow a clockin unless the user is clocked out"
  end
  describe "GET clockout" do
    it "should return false from user.clocked_in?"
    it "should not allow a clockout unless the user is clocked in"
  end
  describe "GET toggle" do
    it "should change the users clock state"
    it "should clock in for a new user"
  end
end


