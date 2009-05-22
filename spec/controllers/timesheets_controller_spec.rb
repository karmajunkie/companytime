require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe TimesheetsController do

  def mock_timesheet(stubs={})
    @mock_timesheet ||= stub_model(Timesheet, stubs)
  end
  
  fixtures(:timesheets)
  fixtures(:users)
  
  describe "GET index" do

    it "exposes all timesheets as @timesheets" do
      Timesheet.should_receive(:find).with(:all).and_return([mock_timesheet])
      get :index
      assigns[:timesheets].should == [mock_timesheet]
    end

    describe "with mime type of xml" do
  
      it "renders all timesheets as xml" do
        Timesheet.should_receive(:find).with(:all).and_return(timesheets = mock("Array of Timesheets"))
        timesheets.should_receive(:to_xml).and_return("generated XML")
        get :index, :format => 'xml'
        response.body.should == "generated XML"
      end
    
    end

  end

  describe "GET show" do

    it "exposes the requested timesheet as @timesheet" do
      ts=timesheets(:march)
      Timesheet.should_receive(:find).with(ts.id.to_s).and_return(ts)
      get :show, :id => ts.id.to_s
      assigns[:timesheet].should equal(ts)
    end
    
    describe "with mime type of xml" do

      it "renders the requested timesheet as xml" do
        ts=timesheets(:march)
        Timesheet.should_receive(:find).with(ts.id.to_s).and_return(ts)
        get :show, :id => ts.id.to_s, :format => 'xml'
        response.body.should == ts.to_xml
      end

    end
    
  end

  describe "GET new" do
  
    it "exposes a new timesheet as @timesheet" do
      ts=mock_model(Timesheet)
      Timesheet.should_receive(:new).and_return(ts)
      get :new
      assigns[:timesheet].should equal(ts)
    end

  end

  describe "GET edit" do
  
    it "exposes the requested timesheet as @timesheet" do
      ts=timesheets(:march)
      Timesheet.should_receive(:find).with(ts.id.to_s).and_return(ts)
      get :edit, :id => ts.id.to_s
      assigns[:timesheet].should equal(ts)
    end

  end

  describe "POST create" do

    describe "with valid params" do
      before(:each) do
        @user=mock_model(User, :save => true)
        User.stub!(:find).and_return(@user)
        @timesheet = mock_timesheet(:save => true, 
                  :start_date => Date.today.beginning_of_month,
                  :end_date= => true,
                  :end_date => Date.today.end_of_month,
                  :user => @user)
        a=[@timesheet]
        a.stub!(:build).and_return(@timesheet)
        @user.stub!(:timesheets => a)

      end
      
      it "exposes a newly created timesheet as @timesheet" do
        post :create, :timesheet => {:these => 'params'}
        assigns(:timesheet).should equal(mock_timesheet)
      end

      it "redirects to the created timesheet" do
        Timesheet.stub!(:new).
          and_return(mock_timesheet(:save => true, 
              :start_date => Date.today.beginning_of_month,
              :end_date= => true,
              :end_date => Date.today.end_of_month))
        post :create, :timesheet => {}
        response.should redirect_to(timesheet_url(mock_timesheet))
      end
      
    end
    
    describe "with invalid params" do
      before(:all) do
        @invalids={
          "user_login" => "keith",
          "timesheet" => {}
        }
      end

      it "exposes a newly created but unsaved timesheet as @timesheet" 
        #mytimesheet=mock_timesheet(:save => false, :[]= => true, :start_date => Date.today.beginning_of_month, :end_date => Date.today.end_of_month)
        #debugger
        #myuser=mock(User, :timesheets => Array.new)
        #myuser.timesheets.stub!(:build).and_return(mytimesheet)
        #Timesheet.stub!(:new).with({"these" => "params"}).and_return(mytimesheet)
        #User.stub!(:find_by_login).with({'user_login' => 'keith'}).and_return(myuser)
        #mytimesheet=mock_timesheet(:save => false)
        #mytimesheet=Timesheet.new(@invalids["timesheet"])

        #Timesheet.stub!(:new).and_return(mytimesheet)
        #post :create, @invalids
        ##post :create, {:user_login=>'keith',:timesheet => {:these => 'params'}}
        #assigns(:timesheet).should equal(mock_timesheet)
      #end

      it "re-renders the 'new' template" 
        #Timesheet.stub!(:new).and_return(mock_timesheet(:save => false))
        #post :create, :timesheet => {}
        #response.should render_template('new')
      #end
      
    end
    
  end

  describe "PUT udpate" do

    describe "with valid params" do

      it "updates the requested timesheet" do
        Timesheet.should_receive(:find).with("37").and_return(mock_timesheet)
        mock_timesheet.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :timesheet => {:these => 'params'}
      end

      it "exposes the requested timesheet as @timesheet" do
        Timesheet.stub!(:find).and_return(mock_timesheet(:update_attributes => true))
        put :update, :id => "1"
        assigns(:timesheet).should equal(mock_timesheet)
      end

      it "redirects to the timesheet" do
        Timesheet.stub!(:find).and_return(mock_timesheet(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(timesheet_url(mock_timesheet))
      end

    end
    
    describe "with invalid params" do

      it "updates the requested timesheet" do
        Timesheet.should_receive(:find).with("37").and_return(mock_timesheet)
        mock_timesheet.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :timesheet => {:these => 'params'}
      end

      it "exposes the timesheet as @timesheet" do
        Timesheet.stub!(:find).and_return(mock_timesheet(:update_attributes => false))
        put :update, :id => "1"
        assigns(:timesheet).should equal(mock_timesheet)
      end

      it "should not allow the creation of a timesheet without a valid login" 
      it "re-renders the 'edit' template" do
        Timesheet.stub!(:find).and_return(mock_timesheet(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end

    end

  end

  describe "DELETE destroy" do

    it "destroys the requested timesheet" do
      Timesheet.should_receive(:find).with("37").and_return(mock_timesheet)
      mock_timesheet.should_receive(:destroy)
      delete :destroy, :id => "37"
    end
  
    it "redirects to the timesheets list" do
      Timesheet.stub!(:find).and_return(mock_timesheet(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(timesheets_url)
    end

  end

end
