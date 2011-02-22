module ProjectsHelper
  def get_available_projects(group)
    result = Array.new
    Project.all.each do |project|
      if project.group == nil || project.group==group
        result.push(project)
      end
    end

    return result
  end
end
