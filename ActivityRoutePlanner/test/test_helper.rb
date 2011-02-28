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
  
  def valid_activity_list
      activity_list = Array.new
      activity_list.push(Activity.new("amenity", "hospital"))
      activity_list.push(Activity.new("amenity", "bank"))
      activity_list.push(Activity.new("amenity", "police"))
      activity_list.push(Activity.new("amenity", "restaurant"))    
      return activity_list
  end
  
  def valid_route_object
    route = Route.new
    route.start_point = Point.new
    route.end_point = Point.new
    route.start_point.label = "53.075878;8.80731"
    route.end_point.label = "53.115878;8.85731"
    
    route.start_point.parse_label
    route.end_point.parse_label    
    
    return route
  end  
  
  def valid_route_without_label_parse
    route = Route.new
    route.start_point = Point.new
    route.end_point = Point.new
    route.start_point.label = "53.075878;8.80731"
    route.end_point.label = "53.115878;8.85731" 
    
    return route
  end
end
