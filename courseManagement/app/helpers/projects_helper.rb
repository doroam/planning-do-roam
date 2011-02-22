module ProjectsHelper
  def get_available_projects()
    result = Array.new
    Project.all.each do |project|
      if project.group == nil
        result.push(group)
      end
    end
    return result
  end
end
