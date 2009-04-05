require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Allocation do
  before(:each) do
    @valid_attributes = {
      :user_id => 1,
      :han => 1.5,
      :ut_gb => 1.5,
      :ut_ss => 1.5,
      :ut_as => 1.5,
      :unrestricted => 1.5
    }
  end

  it "should create a new instance given valid attributes" do
    Allocation.create!(@valid_attributes)
  end
end
