class ActivityController < ApplicationController
  
  #method is called on a action of each 
  #activity
  def update_activity
    route = Route.find(session[:main_route])
    #activity = Activity.new("","")#dummy activity
    
    #add or update activity  
    if params[:activity]
      id = params[:id].to_i
      activity = Activity.find(id)
      if activity!= nil       
          activity.update_activity(route, params[:activity])
      else
        @new_activity = Activity.new()
        splitted = params[:activity].split("$")
        @new_activity.tag = splitted[0]
        @new_activity.value = splitted[1]
        @new_activity.route = route
        @new_activity.save
      end      
    elsif params[:delete_activity]
      index = params[:delete_activity].to_i
      activity = Activity.find(index)      
      activity.destroy
    end    
      
    respond_to do |format|      
      format.js
    end
  end

  def show_markers
    @classes = if params[:class].nil? then [] else params[:class].keys end
    classes_param = @classes.join(',')
    url = "/api/0.6/ontosearch?"
           + "zoom=" + params[:zoom]
           + "&class=" + classes_param
           #+ (intStart=="0" && intStop=="0" ? "" : "&start=" + intStart + "&stop=" + intStop)
           + "&minlon=" + params[:minlon]
           + "&maxlat=" + params[:maxlat]
           + "&minlat=" + params[:minlat]
           + "&maxlon=" + params[:maxlon]
     doc = REXML::Document.new(Net::HTTP.get(URI.parse(url)))
  end

end