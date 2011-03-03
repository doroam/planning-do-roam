class CalculateRouteController < ApplicationController
  #generates a route and shows it
  def calculate_route
    #get session_id
    session_id    = request.session_options[:id]
    #creates fileName
    file_name_app = "kmlRoute_"+session_id+".kml"
    file_name     = "public/"+file_name_app

    #generates the result for the route see GeoResult
    route   = session[:main_route]
    result  = RouteGenerator.generate_route(route);
    
    if File.exist?(file_name)
      File.delete(file_name)
    end

    #Generates the kml of the result
    res           = XmlGenerator.generate_route(result.kml_list)
    params[:kml]  = res
    File.open(file_name, 'w') {|f| f.write(res) }

    #sets the filepath and the result to show errors
    file_path           = file_name_app+"?nocache"+Time.now.to_s
    route.kml_path      = file_path
    params[:file_name]  = file_path
    params[:geo_result] = result
    respond_to do |format|
      format.js
    end
  end
end
