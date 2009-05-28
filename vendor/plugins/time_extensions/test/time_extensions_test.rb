require 'test_helper'

class TimeExtensionsTest < ActiveSupport::TestCase
  
  test "cwday Time" do
    assert_equal 7, Time.now.end_of_week.cwday
  end
  
end
