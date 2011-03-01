require 'test_helper'

class ActivityTest < ActiveSupport::TestCase
  
  test "should create activity object" do
    act = valid_activity_object
    assert act!=nil, "Could not create activiy object"
    assert_equal act.tag, valid_activity_tag, "Activity-tag is not correct"
    assert_equal act.value, valid_activity_value, "Activity-value is not correct"
  end
  
  test "should get possible values" do
    
    route = valid_route_object
    activity = valid_activity_object
    
    assert route!=nil, "Could not create route object"
    assert activity!=nil, "Could not create activityect"        
    
    route.activities.push Activity.new(valid_activity_tag,valid_activity_value)
     
    #session[:main_route] = route
    #session[:main_activity_list] = activity
  end
  
  test "should add activity to list" do
    route = valid_route_object    
    
    assert route != nil, "Route object is nil"
    assert route.activities != nil, "route.activities is nil"
    
    assert_difference(route.activities) do
      route.activities.push Activity.new(valid_activity_tag,valid_activity_value)
    end 
  end
end