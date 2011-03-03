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
  end
  
  test "should add activity to list" do 
    route = valid_route_object
    route.activities.push valid_activity_object
    assert valid_activity_object.addActivity(route, valid_activity_string), 
          "Number of objects in list doent increment."
   end
  
  test "should delete activity from list" do 
    act = valid_activity_object
    
    route = valid_route_object
    route.activities.push act
    assert act.deleteActivity(route, 0), "Delete Activity failed."   
  end
  
  test "change activity" do
     act = Activity.new(valid_activity_tag,valid_activity_value)
     
     route = valid_route_object
     route.activities.push act
     
     assert act.changeActivity(valid_route_object, valid_activity_string,0), "Change Activity failed."  
  end
end