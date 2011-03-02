# To change this template, choose Tools | Templates
# and open the template in the editor.

class Activity
  include Comparable
  attr_accessor :tag, :value, :result
  def initialize
    
  end
  
  def initialize(tag, value)
    @tag = tag
    @value = value
  end
  
  def value
    return @value
  end
  
  def tag
    return @tag
  end
  
  def tag_value
    return @tag+"$"+@value
  end

  def get_image_url
    icon_path = Global::IMAGE_URL_PREFIX
		icon_type = Global::IMAGE_URL_SUFFIX
    icon     = Global::IMAGE_URLS[@tag+"$"+@value]
    if icon == nil
				icon = ""
			end
		return icon_path+icon+icon_type
  end

  def get_image_id
    icon     = Global::IMAGE_URLS[@tag+"$"+@value]
    if icon == nil
				icon = "no_image_found"
			end
		return icon
  end

  #returns possible values to choose activities
  #if a activity is selected, it shell not be selectable
  #again
  def get_possible_values(session)
    possible_values = Array.new
    route = session[:main_route]
    Global::ACTIVITIES.each do |a|
      contains = false
      route.activities.each do |b|
        if b.value.eql? a.value
          contains = true
          break
        end
      end
      if !contains || a.value.eql?(@value)
        possible_values.push a
      end
    end
    return possible_values
  end


  def  <=> (o)
    if self.result==nil
      return 1
    end
    if o.result==nil
      return -1
    end

    result = self.result <=> o.result
    p ":::"+@tag+@value+"  result="+result.to_s
    return result
  end
  
  #add activity to list
  def addActivity(route, act)   
    activity = create_activity(route, act)

    #if activity found
    if activity != nil
      #If activity list contains only spacer -> insert at 0
      #else insert at bevor last position
      if route.activities.length == 1
        route.activities.insert(0, activity)
      else        
        route.activities.insert(-2, activity) 
      end
      return true
    else
      return false
    end    
  end
  
  #change activity
  def changeActivity(route, act, id)
    activity = create_activity(route, act)
    
    #if activity was found
    if activity != nil   
      route.activities[id] = activity
      return true
    else
      return false
    end
  end  

  #delete activity from list
  def deleteActivity(route, index)
    route.kml_path = ""
    activity = route.activities[index.to_i]
    
    #if activity found
    if activity != nil  
       route.activities.delete_at index.to_i
       return true
    else
      return false
    end   
  end

  #create an activiy object
  def create_activity(route, act)
    splitted = act.split("$")
    activity = Activity.new(splitted[0],splitted[1])
    Route.get_closest_activity(activity,route.start_point,route.end_point)
    
    if activity.result == nil
      return nil
    end    
    
    return activity
  end
  
end