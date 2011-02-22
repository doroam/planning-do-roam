require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
  def test_should_create_project
    project = Project.new(:name => "TestProject")
    assert project.save
  end
  
  def test_should_have_2_projects
    assert_equal 2, Project.count
  end
end
