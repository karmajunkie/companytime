require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe HolidaysController do
  describe "route generation" do
    it "maps #index" do
      route_for(:controller => "holidays", :action => "index").should == "/holidays"
    end
  
    it "maps #new" do
      route_for(:controller => "holidays", :action => "new").should == "/holidays/new"
    end
  
    it "maps #show" do
      route_for(:controller => "holidays", :action => "show", :id => "1").should == "/holidays/1"
    end
  
    it "maps #edit" do
      route_for(:controller => "holidays", :action => "edit", :id => "1").should == "/holidays/1/edit"
    end

  it "maps #create" do
    route_for(:controller => "holidays", :action => "create").should == {:path => "/holidays", :method => :post}
  end

  it "maps #update" do
    route_for(:controller => "holidays", :action => "update", :id => "1").should == {:path =>"/holidays/1", :method => :put}
  end
  
    it "maps #destroy" do
      route_for(:controller => "holidays", :action => "destroy", :id => "1").should == {:path =>"/holidays/1", :method => :delete}
    end
  end

  describe "route recognition" do
    it "generates params for #index" do
      params_from(:get, "/holidays").should == {:controller => "holidays", :action => "index"}
    end
  
    it "generates params for #new" do
      params_from(:get, "/holidays/new").should == {:controller => "holidays", :action => "new"}
    end
  
    it "generates params for #create" do
      params_from(:post, "/holidays").should == {:controller => "holidays", :action => "create"}
    end
  
    it "generates params for #show" do
      params_from(:get, "/holidays/1").should == {:controller => "holidays", :action => "show", :id => "1"}
    end
  
    it "generates params for #edit" do
      params_from(:get, "/holidays/1/edit").should == {:controller => "holidays", :action => "edit", :id => "1"}
    end
  
    it "generates params for #update" do
      params_from(:put, "/holidays/1").should == {:controller => "holidays", :action => "update", :id => "1"}
    end
  
    it "generates params for #destroy" do
      params_from(:delete, "/holidays/1").should == {:controller => "holidays", :action => "destroy", :id => "1"}
    end
  end
end
