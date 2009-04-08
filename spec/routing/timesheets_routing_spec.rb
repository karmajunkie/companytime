require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe TimesheetsController do
  describe "route generation" do
    it "maps #index" do
      route_for(:controller => "timesheets", :action => "index").should == "/timesheets"
    end
  
    it "maps #new" do
      route_for(:controller => "timesheets", :action => "new").should == "/timesheets/new"
    end
  
    it "maps #show" do
      route_for(:controller => "timesheets", :action => "show", :id => "1").should == "/timesheets/1"
    end
  
    it "maps #edit" do
      route_for(:controller => "timesheets", :action => "edit", :id => "1").should == "/timesheets/1/edit"
    end

  it "maps #create" do
    route_for(:controller => "timesheets", :action => "create").should == {:path => "/timesheets", :method => :post}
  end

  it "maps #update" do
    route_for(:controller => "timesheets", :action => "update", :id => "1").should == {:path =>"/timesheets/1", :method => :put}
  end
  
    it "maps #destroy" do
      route_for(:controller => "timesheets", :action => "destroy", :id => "1").should == {:path =>"/timesheets/1", :method => :delete}
    end
  end

  describe "route recognition" do
    it "generates params for #index" do
      params_from(:get, "/timesheets").should == {:controller => "timesheets", :action => "index"}
    end
  
    it "generates params for #new" do
      params_from(:get, "/timesheets/new").should == {:controller => "timesheets", :action => "new"}
    end
  
    it "generates params for #create" do
      params_from(:post, "/timesheets").should == {:controller => "timesheets", :action => "create"}
    end
  
    it "generates params for #show" do
      params_from(:get, "/timesheets/1").should == {:controller => "timesheets", :action => "show", :id => "1"}
    end
  
    it "generates params for #edit" do
      params_from(:get, "/timesheets/1/edit").should == {:controller => "timesheets", :action => "edit", :id => "1"}
    end
  
    it "generates params for #update" do
      params_from(:put, "/timesheets/1").should == {:controller => "timesheets", :action => "update", :id => "1"}
    end
  
    it "generates params for #destroy" do
      params_from(:delete, "/timesheets/1").should == {:controller => "timesheets", :action => "destroy", :id => "1"}
    end
  end
end
