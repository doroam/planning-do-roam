require 'test_helper'

class RouteTest < ActiveSupport::TestCase
  test "should create" do
    route = valid_route_object
    
    assert route != nil, "Could not create Route object"
    assert route.start_point != nil, "Route.start_point is nil"
    assert route.end_point != nil, "Route.end_point is nil"
    assert_equal route.sort, valid_route_sort, "Route.sort is not valid"
    assert_equal route.algorithmus, valid_route_algorithmus, "Route.algorithmus is not valid"    
  end
end