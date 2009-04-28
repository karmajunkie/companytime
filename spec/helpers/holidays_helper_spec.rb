require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe HolidaysHelper do
  
  #Delete this example and add some real ones or delete this file
  it "is included in the helper object" do
    included_modules = (class << helper; self; end).send :included_modules
    included_modules.should include(HolidaysHelper)
  end
  
end
