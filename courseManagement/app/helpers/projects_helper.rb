module ProjectsHelper
  def getAvailableProjects()
    result = Array.new
    Project.all.each do |project|
      if project.group == nil
        result.push(group)
      end
    end
    return result
  end
end
