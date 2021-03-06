require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Holiday do
  before(:each) do
    @valid_attributes = {
      :holiday_date => Time.now,
      :name => "value for name",
      :optional => false
    }
  end

  it "should create a new instance given valid attributes" do
    Holiday.create!(@valid_attributes)
  end
end
