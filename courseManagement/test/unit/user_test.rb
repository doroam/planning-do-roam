require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def test_should_create_a_user
    user = User.new(:name => "TestUser", :login => "TestUser")
    assert user.save
  end
  
  def test_should_have_3_users
    assert_equal 3, User.count
  end
  
  def test_should_have_name
    user = User.new(:login => "Test")
    assert !user.save
  end
  
  def test_should_have_login
    user = User.new(:name => "Test")
    assert !user.save
  end
end
