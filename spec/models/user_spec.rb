require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe User do
  before(:each) do
    @valid_attributes = {
      :name => "John Doe",
      :login => "jdoe"
    }
  end

  it "should create a new instance given valid attributes" do
    User.create!(@valid_attributes)
  end
  it "should find the most recent accrual with .first" do
    jd=User.create(@avalid_attributes)
    a = Accrual.new({
      :vacation_hours => 99.0,
      :holiday_hours => 99.0,
      :sick_hours => 99.0,
      :effective_date => Date.today
    })

    b = Accrual.new({
      :vacation_hours => 10.0,
      :holiday_hours => 10.0,
      :sick_hours => 10.0,
      :effective_date => 3.days.from_now
    })
    jd.accruals << a
    jd.accruals << b
    jd.accruals.first.should == b
  end
end
