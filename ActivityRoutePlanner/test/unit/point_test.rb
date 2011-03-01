require 'test_helper'

class PointTest < ActiveSupport::TestCase
  test "should parse label to lat and long" do
    point = valid_point_object_with_label
    point.parse_label
    
    assert_equal point.lat,  valid_point_lat, "Start Point lat is not correct"
    assert_equal point.long, valid_point_long, "Start Point long is not correct"
  end

  test "should initialize point" do
    point = valid_point_object
    
    assert point != nil, "Could not create point object"
    assert_equal point.lat, valid_point_lat, "Point.lat is not correct"
    assert_equal point.long, valid_point_long, "Point.long is not correct"
  end
end