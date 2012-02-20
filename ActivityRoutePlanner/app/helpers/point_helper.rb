module PointHelper
    #sets a point with the entered label
  def set_point_from_result(point)
    label = params[:result][:name]
    if label==nil || "".eql?(label)
      label = params[:result][:lat]+":"+params[:result][:lon]
    end
    set_point_info(point, label, params[:result][:lat],params[:result][:lon])
  end

  def set_point(point)
    label = params[:name]
    if label==nil || "".eql?(label)
      label = params[:lat]+":"+params[:lon]
    end
    set_point_info(point, label, params[:lat],params[:lon])
  end

  def set_point_info(point,label,lat,lon)
    point.label = label
    point.set_coordinates(lat,lon)
    point.set_edge
    point.save
  end
  
end