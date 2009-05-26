require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe User do
  before(:each) do
    @valid_attributes = {
      :first_name => "John",
      :last_name => "Doe",
      :login => "jdoe"
    }
  end

  it "should create a new instance given valid attributes" do
    User.create!(@valid_attributes)
  end
  it "should find return nil for current_accrual if there are none" 
  it "should find the most recent accrual with .current_accrual" do
    jd=User.create(@avalid_attributes)
    jd.save
    t1=Timesheet.new({:start_date => 1.month.ago.beginning_of_month,
                      :end_date =>   1.month.ago.end_of_month,
                      :user_id => 1})
    t2=Timesheet.new({:start_date => 2.month.ago.beginning_of_month,
                      :end_date =>   2.month.ago.end_of_month,
                      :user_id => 1})
    jd.timesheets << t1
    jd.timesheets << t2
    a1 = Accrual.new({
      :vacation_hours => 99.0,
      :holiday_hours => 99.0,
      :sick_hours => 99.0,
      :effective_date => 2.month.ago.beginning_of_month,
      :discriminator =>"start"
    })
    a2 = Accrual.new({
      :vacation_hours => 10.0,
      :holiday_hours => 10.0,
      :sick_hours => 10.0,
      :effective_date => 2.month.ago.end_of_month,
      :discriminator =>"end"
    })

    b1 = Accrual.new({
      :vacation_hours => 10.0,
      :holiday_hours => 10.0,
      :sick_hours => 10.0,
      :effective_date => 1.month.ago.beginning_of_month,
      :discriminator =>"start"

    })
    b2 = Accrual.new({
      :vacation_hours => 22.0,
      :holiday_hours => 20.0,
      :sick_hours => 20.0,
      :effective_date => 1.month.ago.beginning_of_month,
      :discriminator =>"end"

    })
    t1.starting_accrual=a1
    t1.ending_accrual=a2

    t2.starting_accrual=b1
    t2.ending_accrual=b2

    

    jd.current_accrual.should == b2
  end
  
  describe "clocked_in" do
    before do
      @user = Factory(:user)
    end
    
    it "should include users that are clocked in but have never clocked out" do
      Factory(:work_period, :user => @user)
      User.clocked_in.should include(@user)
    end
  end
  describe "clocked_out" do
    before do
      @user = Factory(:user)
    end

    it "should include users that have never clocked in" do
      User.clocked_out.should include(@user)
    end

    it "should not include users that are currently clocked in" do
      Factory(:work_period, :user => @user, :end_time => nil)
      User.clocked_out.should_not include(@user)
    end

    it "should not include users that have clocked out before and are currently clocked in" do
      Factory(:work_period, :user => @user, :end_time => Time.now)
      Factory(:work_period, :user => @user, :end_time => nil)
      User.clocked_out.should_not include(@user)
    end


    it "should include users that are currently clocked out" do
      Factory(:work_period, :user => @user, :end_time => Time.now)
      User.clocked_out.should include(@user)
    end
  end
end
