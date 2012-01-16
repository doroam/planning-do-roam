class Route < ActiveRecord::Base
  include RouteHelper

  has_many :activities

  #contains the main information of the application
  GLOBAL_FIELD_NAME     = Global::GLOBAL_FIELD_NAME
  GLOBAL_FIELD_LONG     = Global::GLOBAL_FIELD_LONG
  GLOBAL_FIELD_LAT      = Global::GLOBAL_FIELD_LAT
  GLOBAL_TABLE_POINT    = Global::GLOBAL_TABLE_POINT
  GLOBAL_TABLE_POLYGON  = Global::GLOBAL_TABLE_POLYGON
  GLOBAL_FIELD_AMENITY  = Global::GLOBAL_FIELD_AMENITY
  
  #initalizes a route
  def initialize(*params)
    super(*params)
    self.sort = "false"
    self.algorithmus = "A*"
    self.optimization = "ENERGY"
    self.car_type = "STROMOS"
    point = Point.new()
    point.save
    self.start_point_id = point.id
    point = Point.new()
    point.save
    self.end_point_id = point.id
    self.save
  end

  #if the route is ready for routing
  def is_ready
    return self.end_point!= nil  && self.end_point.is_setted && self.start_point!=nil && self.start_point.is_setted
  end

  #gets the end point
  def end_point
    point = nil
    if self.end_point_id!=nil
      point = Point.find(self.end_point_id)
    end
    return point
  end
  #gets the start point
  def start_point
    point = nil
    if self.start_point_id!=nil
      point = Point.find(self.start_point_id)
    end
    return point
  end

  #resets a route
  def reset
    self.activities.delete_all
    self.kml_path = ""
    self.save
  end

  #Creates javascript code to show the Marks of the selected route
  def show_markers()
    script = ""
    start_point = self.start_point
    #adds start mark
    if start_point != nil && start_point.is_setted
      script = "addMark('"+start_point.label_js+"','"+start_point.lat.to_s+"','"+start_point.lon.to_s+"','start');"
    end
    end_point = self.end_point
    #adds end mark
    if end_point != nil && end_point.is_setted
      script += "addMark('"+end_point.label_js+"','"+end_point.lat.to_s+"','"+end_point.lon.to_s+"','end');"
    end

    activities = self.activities
    
    #adds activities mark
    activities.each do |activity|
      if activity.result != nil
        imagePath = activity.get_image_url()
        result    = activity.result
        
        script += "addActivityMark('"+result.label_js+"','"+result.lat.to_s+"','"+result.lon.to_s+"','"+imagePath+"','"+activity.id.to_s+"');"
      end
    end

    kml_path = self.kml_path

    #adds the route if there is one
    if kml_path != nil && !kml_path.eql?("")
      script += "loadRoute('"+kml_path+"');"
    end
    return script
  end

end