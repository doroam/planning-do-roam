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

  #gets the image url of the activity
  def get_image_url
    icon_path = Global::IMAGE_URL_PREFIX
		icon_type = Global::IMAGE_URL_SUFFIX
    icon      = Global::IMAGE_URLS[self.tag+"$"+self.value]

    if icon == nil
      return "javascripts/img/marker-green.png"
    else
      return icon_path+icon+icon_type
    end
		
  end

  #gets the id of the activity. it is the name of the icon
  def get_image_id
    icon     = Global::IMAGE_URLS[self.tag+"$"+self.value]
    if icon == nil
				icon = "no_image_found"
			end
		return icon
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

end