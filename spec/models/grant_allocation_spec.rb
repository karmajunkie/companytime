require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe GrantAllocation do
  before(:each) do
    @valid_attributes = {
      :grant_id => 1,
      :user_id => 1,
      :weight => 1.5
    }
  end

  it "should create a new instance given valid attributes" do
    GrantAllocation.create!(@valid_attributes)
  end
end
