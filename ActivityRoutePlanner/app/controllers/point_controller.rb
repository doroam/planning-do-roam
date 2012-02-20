class PointController < ApplicationController
  
  #controller is called on each activity action
  def update_point
    @route = current_route
    
    #start point was set
    if params[:type]=="start"
      point = @route.start_point
      @type = 'start'
    else
      point = @route.end_point
      @type = 'end'
    end

    if point != nil
      if params[:result]!= nil
        point.set_point_from_result(params[:result])
      else
        set_point(point)
      end
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


  #handles errors by parsing lables of a point
  def handle_error(point,label)
    if point.label == nil || point.label.eql?("")
      flash[:error_msg] = "The place could not be found"
    else
      flash[:error_msg] = nil
    end
  end
end
