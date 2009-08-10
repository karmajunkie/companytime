require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe User do
	describe "validations" do
		before(:each) do
			@user = Factory.build(:user)
		end

		it "should be valid" do
			@user.valid?.should be_true
		end
		it "should not be valid without an email" do
		  @user.email = ""
		  @user.valid?.should be_false
		end

		it "should not be valid without a first name" do
		  @user.first_name = ""
		  @user.valid?.should be_false
		end

		it "should not be valid without a last name" do
		  @user.last_name = ""
		  @user.valid?.should be_false
		end

		it "should be invalid if a Person already exists with same email" do
		  Factory(:user, :email => "joe@example.com")
		  @user.email = "joe@example.com"
		  @user.valid?.should be_false
		end

	end
  before(:each) do
    @valid_attributes = {
      :first_name => "John",
      :last_name => "Doe",
      :login => "jdoe"
    }
  end

  it "should find return nil for current_accrual if there are none" do
	  user=Factory(:user)
	  user.current_accrual.should be_nil
  end
  it "should find the most recent accrual with .current_accrual" do
    jd=Factory(:user)
    t1=Factory(:timesheet, :start_date => 1.month.ago.beginning_of_month,
                      :end_date =>   1.month.ago.end_of_month, :user => jd)
    t2=Factory(:timesheet, :start_date => 2.month.ago.beginning_of_month,
                      :end_date =>   2.month.ago.end_of_month, :user => jd)
    jd.current_accrual.should == t1.ending_accrual
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
