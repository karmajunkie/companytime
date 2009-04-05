require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe TimesheetsController do

  def mock_timesheet(stubs={})
    @mock_timesheet ||= mock_model(Timesheet, stubs)
  end
  
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
      Timesheet.should_receive(:find).with("37").and_return(mock_timesheet)
      get :show, :id => "37"
      assigns[:timesheet].should equal(mock_timesheet)
    end
    
    describe "with mime type of xml" do

      it "renders the requested timesheet as xml" do
        Timesheet.should_receive(:find).with("37").and_return(mock_timesheet)
        mock_timesheet.should_receive(:to_xml).and_return("generated XML")
        get :show, :id => "37", :format => 'xml'
        response.body.should == "generated XML"
      end

    end
    
  end

  describe "GET new" do
  
    it "exposes a new timesheet as @timesheet" do
      Timesheet.should_receive(:new).and_return(mock_timesheet)
      get :new
      assigns[:timesheet].should equal(mock_timesheet)
    end

  end

  describe "GET edit" do
  
    it "exposes the requested timesheet as @timesheet" do
      Timesheet.should_receive(:find).with("37").and_return(mock_timesheet)
      get :edit, :id => "37"
      assigns[:timesheet].should equal(mock_timesheet)
    end

  end

  describe "POST create" do

    describe "with valid params" do
      
      it "exposes a newly created timesheet as @timesheet" do
        Timesheet.should_receive(:new).with({'these' => 'params'}).and_return(mock_timesheet(:save => true))
        post :create, :timesheet => {:these => 'params'}
        assigns(:timesheet).should equal(mock_timesheet)
      end

      it "redirects to the created timesheet" do
        Timesheet.stub!(:new).and_return(mock_timesheet(:save => true))
        post :create, :timesheet => {}
        response.should redirect_to(timesheet_url(mock_timesheet))
      end
      
    end
    
    describe "with invalid params" do

      it "exposes a newly created but unsaved timesheet as @timesheet" do
        Timesheet.stub!(:new).with({'these' => 'params'}).and_return(mock_timesheet(:save => false))
        post :create, :timesheet => {:these => 'params'}
        assigns(:timesheet).should equal(mock_timesheet)
      end

      it "re-renders the 'new' template" do
        Timesheet.stub!(:new).and_return(mock_timesheet(:save => false))
        post :create, :timesheet => {}
        response.should render_template('new')
      end
      
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
