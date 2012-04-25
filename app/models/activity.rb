class Activity < ActiveRecord::Base
  has_one :point
  belongs_to :route

  include Comparable
  
  def result
    return self.point
  end

  def is_empty
    return self.point.icon==nil
  end

  #gets the image url of the activity
  def get_image_url
    return self.point.icon		
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