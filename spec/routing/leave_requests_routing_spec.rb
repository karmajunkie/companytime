require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe LeaveRequestsController do
  describe "route generation" do
    it "maps #index" do
      route_for(:controller => "leave_requests", :action => "index").should == "/leave_requests"
    end
  
    it "maps #new" do
      route_for(:controller => "leave_requests", :action => "new").should == "/leave_requests/new"
    end
  
    it "maps #show" do
      route_for(:controller => "leave_requests", :action => "show", :id => "1").should == "/leave_requests/1"
    end
  
    it "maps #edit" do
      route_for(:controller => "leave_requests", :action => "edit", :id => "1").should == "/leave_requests/1/edit"
    end

  it "maps #create" do
    route_for(:controller => "leave_requests", :action => "create").should == {:path => "/leave_requests", :method => :post}
  end

  it "maps #update" do
    route_for(:controller => "leave_requests", :action => "update", :id => "1").should == {:path =>"/leave_requests/1", :method => :put}
  end
  
    it "maps #destroy" do
      route_for(:controller => "leave_requests", :action => "destroy", :id => "1").should == {:path =>"/leave_requests/1", :method => :delete}
    end
  end

  describe "route recognition" do
    it "generates params for #index" do
      params_from(:get, "/leave_requests").should == {:controller => "leave_requests", :action => "index"}
    end
  
    it "generates params for #new" do
      params_from(:get, "/leave_requests/new").should == {:controller => "leave_requests", :action => "new"}
    end
  
    it "generates params for #create" do
      params_from(:post, "/leave_requests").should == {:controller => "leave_requests", :action => "create"}
    end
  
    it "generates params for #show" do
      params_from(:get, "/leave_requests/1").should == {:controller => "leave_requests", :action => "show", :id => "1"}
    end
  
    it "generates params for #edit" do
      params_from(:get, "/leave_requests/1/edit").should == {:controller => "leave_requests", :action => "edit", :id => "1"}
    end
  
    it "generates params for #update" do
      params_from(:put, "/leave_requests/1").should == {:controller => "leave_requests", :action => "update", :id => "1"}
    end
  
    it "generates params for #destroy" do
      params_from(:delete, "/leave_requests/1").should == {:controller => "leave_requests", :action => "destroy", :id => "1"}
    end
  end
end
