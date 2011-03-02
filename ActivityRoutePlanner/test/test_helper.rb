ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...
  
  #activity helper start
  def valid_activity_list
      activity_list = Array.new   
      activity_list[
        Activity.new("amenity", "hospital"),
        Activity.new("amenity", "bank"),
        Activity.new("amenity", "police"),
        Activity.new("amenity", "restaurant")
      ]
      return activity_list
  end
  def valid_activity_object
    return Activity.new(valid_activity_tag, valid_activity_value)
  end
  def valid_activity_tag
    return "amenity"
  end
  def valid_activity_value
    return "police"
  end
  #activity end
  #route helper start
  def valid_route_object
    route = Route.new
    route.start_point = Point.new
    route.end_point = Point.new
    route.start_point.label = "53.075878;8.80731"
    route.end_point.label = "53.115878;8.85731"
    
    route.start_point.parse_label
    route.end_point.parse_label 
    
    route.activities = Array.new
    
    return route
  end  
  
  def valid_route_without_label_parse
    route = Route.new
    route.start_point = Point.new
    route.end_point = Point.new
    route.start_point.label = "53.075878;8.80731"
    route.end_point.label = "53.115878;8.85731" 
    route.activities = Array.new
    
    return route
  end  
  def valid_route_algorithmus
    return "A*"
  end
  def valid_route_sort
    return "false"
  end
  #Route end
  #Point helper start
  def valid_point_attributes
    {
    :label=> valid_point_label,
    :lat=> valid_point_lat,
    :long=> valid_point_long    
    }
  end
  def valid_point_object
    point = Point.new
    point.label = valid_point_label
    point.lat = valid_point_lat
    point.long = valid_point_long
    return point
  end
  def valid_point_object_with_label
    point = Point.new
    point.label = valid_point_label
    return point
  end
  def valid_point_lat
    return "53.075878"
  end
  def valid_point_long
    return "8.80731"
  end
  def valid_point_label
    return "53.075878;8.80731"
  end
  #Point helper end
end
