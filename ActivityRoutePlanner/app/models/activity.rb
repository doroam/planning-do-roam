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

end