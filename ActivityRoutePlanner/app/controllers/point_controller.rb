class PointController < ApplicationController

  #controller is called on each activity action
  def update_point
    @route = Route.find(session[:main_route])
    
    point = nil
    #start point was set
    if params[:start]!=nil
      point = @route.start_point
      @type = 'start'
    elsif params[:end]!=nil
      point = @route.end_point
      @type = 'end'
    end

    if point != nil
      if params[:result]!= nil
        set_point_from_result(point)
      else
        set_point(point)
      end
      #@route.reset()
    end
    respond_to do |format|
      format.js
#      format.html render :partial => "point_form"
    end
  end


  #removes a point
  def remove_point
    @route = Route.find(session[:main_route])
    point = nil
    if params[:delete_point].eql? "start"
      point = @route.start_point
      @type = 'start'
    elsif params[:delete_point].eql? "end"
      point = @route.end_point
      @type = 'end'
    end
    #@route.reset()
    if point != nil
      point.reset
      point.save
    end
    

    respond_to do |format|
      format.js
    end
  end

  
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
  

  #handles errors by parsing lables of a point
  def handle_error(point,label)
    if point.label == nil || point.label.eql?("")
      flash[:error_msg] = "The place could not be found"
    else
      flash[:error_msg] = nil
    end
  end
end
