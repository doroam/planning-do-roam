module GroupsHelper
  def get_available_groups()
    result = Array.new
    Group.all.each do |group|
      if group.users == nil || group.users.length<2
        result.push(group)
      end
    end

    return result
  end
end
