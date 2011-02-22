require 'test_helper'

class GroupTest < ActiveSupport::TestCase
  def test_should_create_group
    group = Group.new(valid_group)
    assert group.save
  end
  
  def test_should_have_3_groups
    assert_equal 3, Group.count
  end
end
