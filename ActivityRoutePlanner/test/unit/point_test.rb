require 'test_helper'

class PointTest < ActiveSupport::TestCase
  test "should parse label to lat and long" do
    route = valid_route_without_label_parse
    
    route.end_point.parse_label
    route.start_point.parse_label
    
    assert_equal route.start_point.lat  "53.075878" "Start Point lat is not correct"
    assert_equal route.start_point.long "8.80731" "Start Point long is not correct"
    
    assert_equal route.end_point.lat "53.115878"  "End Point lat is not correct"
    assert_equal route.end_point.long "8.85731" "End Point long is not correct"
  end

end
