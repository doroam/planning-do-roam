require 'test_helper'

class ActivityControllerTest < ActionController::TestCase
  
  test "ajax redirect test" do
    
  end
  
  test "delete activity" do
    act = valid_activity_list
    assert_difference(act.count, -1) do
      
    end
  end
  
  test "add activity" do
    
  end
  
  test "change activity" do
    
  end
  
  test "create activity" do
    
  end
end