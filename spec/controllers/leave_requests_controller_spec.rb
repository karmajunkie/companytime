require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe LeaveRequestsController do

  def mock_leave_request(stubs={})
    @mock_leave_request ||= mock_model(LeaveRequest, stubs)
  end
  
  describe "GET index" do
    it "assigns all leave_requests as @leave_requests" do
      LeaveRequest.stub!(:find).with(:all).and_return([mock_leave_request])
      get :index
      assigns[:leave_requests].should == [mock_leave_request]
    end
  end

  describe "GET show" do
    it "assigns the requested leave_request as @leave_request" do
      LeaveRequest.stub!(:find).with("37").and_return(mock_leave_request)
      get :show, :id => "37"
      assigns[:leave_request].should equal(mock_leave_request)
    end
  end

  describe "GET new" do
    it "assigns a new leave_request as @leave_request" do
      LeaveRequest.stub!(:new).and_return(mock_leave_request)
      get :new
      assigns[:leave_request].should equal(mock_leave_request)
    end
  end

  describe "GET edit" do
    it "assigns the requested leave_request as @leave_request" do
      LeaveRequest.stub!(:find).with("37").and_return(mock_leave_request)
      get :edit, :id => "37"
      assigns[:leave_request].should equal(mock_leave_request)
    end
  end

  describe "POST create" do
    
    describe "with valid params" do
      it "assigns a newly created leave_request as @leave_request" do
        LeaveRequest.stub!(:new).with({'these' => 'params'}).and_return(mock_leave_request(:save => true))
        post :create, :leave_request => {:these => 'params'}
        assigns[:leave_request].should equal(mock_leave_request)
      end

      it "redirects to the created leave_request" do
        LeaveRequest.stub!(:new).and_return(mock_leave_request(:save => true))
        post :create, :leave_request => {}
        response.should redirect_to(leave_request_url(mock_leave_request))
      end
    end
    
    describe "with invalid params" do
      it "assigns a newly created but unsaved leave_request as @leave_request" do
        LeaveRequest.stub!(:new).with({'these' => 'params'}).and_return(mock_leave_request(:save => false))
        post :create, :leave_request => {:these => 'params'}
        assigns[:leave_request].should equal(mock_leave_request)
      end

      it "re-renders the 'new' template" do
        LeaveRequest.stub!(:new).and_return(mock_leave_request(:save => false))
        post :create, :leave_request => {}
        response.should render_template('new')
      end
    end
    
  end

  describe "PUT update" do
    
    describe "with valid params" do
      it "updates the requested leave_request" do
        LeaveRequest.should_receive(:find).with("37").and_return(mock_leave_request)
        mock_leave_request.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :leave_request => {:these => 'params'}
      end

      it "assigns the requested leave_request as @leave_request" do
        LeaveRequest.stub!(:find).and_return(mock_leave_request(:update_attributes => true))
        put :update, :id => "1"
        assigns[:leave_request].should equal(mock_leave_request)
      end

      it "redirects to the leave_request" do
        LeaveRequest.stub!(:find).and_return(mock_leave_request(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(leave_request_url(mock_leave_request))
      end
    end
    
    describe "with invalid params" do
      it "updates the requested leave_request" do
        LeaveRequest.should_receive(:find).with("37").and_return(mock_leave_request)
        mock_leave_request.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :leave_request => {:these => 'params'}
      end

      it "assigns the leave_request as @leave_request" do
        LeaveRequest.stub!(:find).and_return(mock_leave_request(:update_attributes => false))
        put :update, :id => "1"
        assigns[:leave_request].should equal(mock_leave_request)
      end

      it "re-renders the 'edit' template" do
        LeaveRequest.stub!(:find).and_return(mock_leave_request(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end
    end
    
  end

  describe "DELETE destroy" do
    it "destroys the requested leave_request" do
      LeaveRequest.should_receive(:find).with("37").and_return(mock_leave_request)
      mock_leave_request.should_receive(:destroy)
      delete :destroy, :id => "37"
    end
  
    it "redirects to the leave_requests list" do
      LeaveRequest.stub!(:find).and_return(mock_leave_request(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(leave_requests_url)
    end
  end

end
