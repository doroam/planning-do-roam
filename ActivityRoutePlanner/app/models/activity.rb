class Activity < ActiveRecord::Base
  has_one :point
  belongs_to :route

  include Comparable


  def tag_value
    if self.tag!=nil && self.value!=nil
      return self.tag+"$"+self.value
    end
      return ""
  end

  def result
    return self.point
  end

  def is_empty
    return self.tag==nil  && self.value==nil
  end

  def self.set(tag,value)
    @activity = Activity.new
    @activity.tag = tag
    @activity.value = value
    return @activity
  end

  #gets the image url of the activity
  def get_image_url
    icon_path = Global::IMAGE_URL_PREFIX
		icon_type = Global::IMAGE_URL_SUFFIX
    icon      = Global::IMAGE_URLS[self.tag+"$"+self.value]
    if icon == nil
				icon = ""
			end
		return icon_path+icon+icon_type
  end

  #gets the id of the activity. it is the name of the icon
  def get_image_id
    icon     = Global::IMAGE_URLS[self.tag+"$"+self.value]
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
    route = Route.find(session[:main_route])
    Global::ACTIVITIES.each do |a|
      contains = false
      route.activities.each do |b|
        if b.value.eql? a.value
          contains = true
          break
        end
      end
      if !contains || a.value.eql?(self.value)
        possible_values.push a
      end
    end
    return possible_values
  end

  #comparator for activities
  #it compares the result point
  #see <=> of class point
  def  <=> (o)
    if self.result==nil
      return 1
    end
    if o.result==nil
      return -1
    end

    result = self.result <=> o.result
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
    activity = route.activities[index]
    
    #if activity found
    if activity != nil  
       route.activities.delete_at index
       return true
    else
      return false
    end   
  end

  #create an activiy object
  def update_activity(route, act)
    set_empty = self.is_empty
    #parse the value to get tag and value
    splitted = act.split("$")
    self.tag = splitted[0]
    self.value = splitted[1]
    self.save
    result = Route.get_closest_activity(self,route.start_point,route.end_point)
    result.activity = self
    result.save
    
    if set_empty
      @activity = Activity.new()
      @activity.route = route
      @activity.save
    end
  end
  
end