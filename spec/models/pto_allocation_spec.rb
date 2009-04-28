require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PtoAllocation do
  fixtures("timesheets")
  fixtures("pto_allocations")
  fixtures("holidays")
  before(:each) do
    @valid_attributes = {
      :timesheet_id => 1,
      :allocation_date => Time.now,
      :sick => 1.5,
      :vacation => 1.5,
      :holiday => 1.5
    }
  end

  it "should create a new instance given valid attributes" do
    PtoAllocation.create!(@valid_attributes)
  end
  it "(stubs version) should return only PtoAllocations on holidays using .holiday named scope" do
    pto=stub_model(PtoAllocation, :allocation_date => Date.new(2009,3,17).to_time.beginning_of_day)
    PtoAllocation.stub!(:find).and_return([pto])
    ts=stub_model(Timesheet)
    hols=ts.pto_allocations.holidays
    hols.should include(pto)
    hols.size.should == 1
  end
end
  #it "should return only PtoAllocations on holidays using .holiday named scope" do
    #ts=timesheets(:march)
    #pto=pto_allocations(:march_17)
#
    #hols=ts.pto_allocations.holidays
    #hols.should include( pto)
    #hols.size.should == 1
  #end
