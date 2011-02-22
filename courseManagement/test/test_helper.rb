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
  
  def set_user_id_to_session(id)
    session[:login_user_id] = id
  end
  
  def valid_professor_user
    {
      :name => "Professor",
      :login => "prof",
      :is_professor => true
    }
  end
  
  def valid_student_user
    {
      :name => "Student",
      :login => "stud",
      :is_professor => false    
    }
  end
  
  def valid_group
    {
      :name => "TestGroup"
    }    
  end
  
  def valid_project
    {
      :name => "TestProject"
    }
  end
end
