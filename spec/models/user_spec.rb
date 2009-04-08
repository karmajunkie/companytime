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
    t1=Timesheet.new({:start_date => 1.month.ago.beginning_of_month,
                      :end_date =>   1.month.ago.end_of_month,
                      :user_id => 1})
    t2=Timesheet.new({:start_date => 2.month.ago.beginning_of_month,
                      :end_date =>   2.month.ago.end_of_month,
                      :user_id => 1})
    a = Accrual.new({
      :vacation_hours => 99.0,
      :holiday_hours => 99.0,
      :sick_hours => 99.0,
      :effective_date => 2.month.ago.beginning_of_month
    })

    b = Accrual.new({
      :vacation_hours => 10.0,
      :holiday_hours => 10.0,
      :sick_hours => 10.0,
      :effective_date => 1.month.ago.beginning_of_month
    })
    t1.accrual=a
    t2.accrual=b
    jd.timesheets << t1
    jd.timesheets << t2

    jd.accruals.first.effective_date.should == 1.month.ago.beginning_of_month
  end
end
