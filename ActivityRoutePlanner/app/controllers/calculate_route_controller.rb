class CalculateRouteController < ApplicationController  
  include CalculateRouteHelper
  include RouteHelper
  
  #generates a route and shows it
  def calculate_route        
    #get session_id
    session_id    = request.session_options[:id]
    #creates fileName
    file_name_app = "kmlRoute_"+session_id+".kml"
    file_name     = "public/"+file_name_app

    #generates the result for the route see GeoResult
    route   = Route.find(session[:main_route])
    result  = RouteHelper.generate_route(route);
    
    if File.exist?(file_name)
      File.delete(file_name)
    end

    #Generates the kml of the result
    res           = CalculateRouteHelper.generate_route(result.kml_list)
    params[:kml]  = res
    File.open(file_name, 'w') {|f| f.write(res) }

    #sets the filepath and the result to show errors
    file_path           = file_name_app+"?nocache"+Time.now.to_s
    route.kml_path      = file_path
    route.save
    params[:file_name]  = file_path
    params[:geo_result] = result
    respond_to do |format|
      format.js
    end
  end

  #sets the algorithmus and sorting method to use
  def set_algorithmus
    a     = params[:algo]
    route = Route.find(session[:main_route])
    sort  = params[:sort]

    if a != nil
      route.algorithmus = a
    elsif sort != nil
      route.sort = sort
    end
    route.save
    respond_to do |format|
      format.js
    end
  end

  def get_energy_route
    require 'net/http'

    url = URI.parse("http://greennav.in.tum.de:8192/routing/createRoutingResponseXMLString")

    xml = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>"+
      "<routingRequest ID=\"11:32:56 STROMOS 234\">"+
      "<feature>rangePrediction</feature>"+
      "<startNode>"+
      "<geoCoords latitude=\"47.733333\" longitude=\"10.316667\"/>"+
      "</startNode>"+
      "<vehicleType>STROMOS</vehicleType>"+
      "<batteryChargeAtStart>95</batteryChargeAtStart>"+
      "<resultType>geoCoords</resultType>"+
      "</routingRequest>"

    params = { 'createRoutingResponseXMLString' => xml,"Content-type" => "text/xml" }

    @resp, @data = Net::HTTP.post_form(url, params)

    p "respo="+@resp.to_s+"   data="+@data.to_s
    
  end
end
