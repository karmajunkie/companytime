require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PtoAllocationsController do

  #Delete these examples and add some real ones
  it "should use PtoAllocationsController" do
    controller.should be_an_instance_of(PtoAllocationsController)
  end


  describe "GET 'update'" do
    fixtures(:pto_allocations)
    fixtures(:timesheets)
    fixtures(:accruals)
    it "should be successful" do
      pto=pto_allocations(:march_01)
      ts=timesheets(:march)
      PtoAllocation.should_receive(:find).with(pto.id.to_s).and_return(pto)
      Timesheet.should_receive(:find).and_return(ts)
      get 'update', {:id => pto.id.to_s, :type => "holiday", :hours => "-5.0"}
      response.should be_success
    end
  end

  describe "GET 'reset'" do
    it "should be successful" do
      get 'reset'
      response.should be_success
    end
  end
end
