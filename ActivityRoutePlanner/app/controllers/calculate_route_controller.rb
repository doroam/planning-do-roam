class CalculateRouteController < ApplicationController
  include CalculateRouteHelper
  include RouteHelper
  require 'CGI'
  
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
  def set_route_parameters
    a     = params[:algo]
    route = Route.find(session[:main_route])
    sort  = params[:sort]
    optimization = params[:optimization]
    car_type = params[:car_type]

    #set algorithmus
    if a != nil
      route.algorithmus = a
    end
    #set sort flag
    if sort != nil
      route.sort = sort
    end
    #set car type
    if car_type != nil
      route.car_type = car_type
    end
    #set optimization flag
    if optimization != nil
      route.optimization = optimization
    end

    route.save
    respond_to do |format|
      format.js
    end
  end

  #not in use
  def get_energy_route

    nodes = Array.new

    #service url
    url = "http://greennav.in.tum.de:8192/routing?wsdl"
    
    #test xml
    xml = 
      "<routingRequest ID=\"test\">"+
      "<feature>routeCalculation</feature>"+
      "<startNode>"+
      "<geoCoords latitude=\"47.733333\" longitude=\"10.316667\"/>"+
      "</startNode>"+
      "<targetNode>"+
      "<geoCoords latitude=\"47.733433\" longitude=\"10.316567\"/>"+
      "</targetNode>"+
      "<vehicleType>STROMOS</vehicleType>"+
      "<batteryChargeAtStart>95</batteryChargeAtStart>"+
      "<resultType>geoCoords</resultType>"+
      "</routingRequest>"
    
    xml = "<?xml version=\"1.0\" ?>"+
      "<S:Envelope xmlns:S=\"http://schemas.xmlsoap.org/soap/envelope/\">"+
      "<S:Body>"+
      "<ns2:createRoutingResponseXMLString xmlns:ns2=\"http://server.greennav.in.tum.de/\"><arg0>"+
        "&lt;?xml version=&quot;1.0&quot; encoding=&quot;UTF-8&quot;?&gt;"+
        "&lt;routingRequest ID=&quot;11:32:56 STROMOS 234&quot;&gt;"+
        "&lt;feature&gt;rangePrediction&lt;/feature&gt;"+
        "&lt;startNode&gt;"+
        "&lt;geoCoords latitude=&quot;47.733333&quot; longitude=&quot;10.316667&quot;/&gt;"+
        "&lt;/startNode&gt;"+
        "&lt;vehicleType&gt;STROMOS&lt;/vehicleType&gt;&lt;batteryChargeAtStart&gt;95&lt;/batteryChargeAtStart&gt;"+
        "&lt;resultType&gt;geoCoords&lt;/resultType&gt;"+
        "&lt;/routingRequest&gt;"+
      "</arg0></ns2:createRoutingResponseXMLString></S:Body></S:Envelope>"

    @error = ""
    begin
      client = Savon::Client.new do
          wsdl.document = url
      end



      #@res = client.request :wsdl, :create_routing_response_xml_string, "khkh" => @xml_doc
      @actions = client.wsdl.soap_actions
      @res = client.request :wsdl,:create_routing_response_xml_string do |soap|
        soap.xml = xml
      end

      xml_string = @res.to_hash[:create_routing_response_xml_string_response][:return]
      coords = REXML::Document.new(xml_string)
      @result = "xml=="+coords.elements["routingResponse/nodes"].size.to_s
      #gets the result points
      nodes = get_points(coords.elements["routingResponse/nodes"])
      

    rescue Exception => err
      @error = err.to_s
      p "error="+err.to_s
    end
    p "test="+@res.to_xml.to_s

    return nodes

  end


end
