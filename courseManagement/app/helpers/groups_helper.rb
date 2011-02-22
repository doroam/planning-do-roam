module GroupsHelper
  def get_available_groups()
    result = Array.new
    user_id = session[:login_user_id]
    user    = User.find(user_id)
    Group.all.each do |group|
      if group.users == nil || group.users.length<2 || ((group.users).include? user)
        result.push(group)
      end
    end
    return result
  end
end
