class CalculateRouteController < ApplicationController
  def calculate_route
    session_id    = request.session_options[:id]
    file_name_app = "kmlRoute_"+session_id+".kml"
    file_name     = "public/"+file_name_app

    route   = session[:main_route]
    result  = RouteGenerator.generate_route(route);
    
    if File.exist?(file_name)
      File.delete(file_name)
    end

    res           = XmlGenerator.generate_route(result.kml_list)
    params[:kml]  = res
    File.open(file_name, 'w') {|f| f.write(res) }

    file_path           = file_name_app+"?nocache"+Time.now.to_s
    route.kml_path      = file_path
    params[:file_name]  = file_path
    params[:geo_result] = result
    respond_to do |format|
      format.js
    end
  end
end
