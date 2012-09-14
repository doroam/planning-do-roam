class CalculateRouteController < ApplicationController
  include CalculateRouteHelper
  include RouteHelper
  require 'cgi'
  require 'nokogiri'
  
  #generates a route and shows it
  def calculate_route
    
    #save route
    @route   = current_route
    @route.setCalc(params[:sort], params[:setAlgorithmus], params[:optimization], params[:car_type])
    
    #get session_id
    session_id    = request.session_options[:id]
    
    #generates the result for the route see GeoResult
    
    case @route.algorithmus
    when "osrm"
      output = "GPX"
      file_name_app = "osrm_"+session_id+".#{output}"
      file_name     = "public/"+file_name_app
      if File.exist?(file_name)
        File.delete(file_name)
      end
      #start-location
      locs = "loc=#{@route.start_point.lat},#{@route.start_point.lon}"
      if(!@route.start_point.hint.nil?)
        locs += "&hint=" + @route.start_point.hint.to_s
      end
      #waypoints
      @route.activities.each do |activity|        
        locs += "&loc=#{activity.point.lat},#{activity.point.lon}"
        if(!activity.point.hint.nil?)
          locs += "&hint=" + activity.point.hint.to_s
        end
      end
      #end-location
      locs += "&loc=#{@route.end_point.lat},#{@route.end_point.lon}"
      if(!@route.end_point.hint.nil?)
        locs += "&hint=" + @route.end_point.hint.to_s
      end
      if(!@route.checksum.nil?)
        locs += "&checksum=" + @route.checksum.to_s
      end
      begin
        File.open(file_name, 'wb') do |file|
          puts "http://router.project-osrm.org/viaroute?#{locs}&z=15&output=#{output}&instructions=false"
          file.write(open("http://router.project-osrm.org/viaroute?#{locs}&z=15&output=#{output}&instructions=false").read)
          gpx = Nokogiri::XML(file)
          #gpx = 
        end
      rescue
        putr "No connection to OSRM-Website possible"
      end
      
      #sets the filepath and the result to show errors
      @route.kml_path      = file_name_app+"?nocache"+Time.now.to_s
      @route.format = output
      @route.save
      respond_to do |format|
        format.js {render :locals => {:format => output}}
      end
      return
    when "yours"
      file_name_app = "yours_"+session_id+".kml"
      file_name     = "public/"+file_name_app
      if File.exist?(file_name)
        File.delete(file_name)
      end
      begin
        before = @route.start_point
        @i=0
        @route.activities.each do |activity|
          File.open(file_name+@i.to_s, 'wb') do |file|
            file.write(open("http://www.yournavigation.org/api/1.0/gosmore.php?format=kml&flat=#{before.lat}&flon=#{before.lon}&tlat=#{activity.point.lat}&tlon=#{activity.point.lon}&v=motorcar&fast=1&layer=mapnik").read)
          end
          before = activity.point
          @i+=1
        end
        File.open(file_name+@i.to_s, 'wb') do |file|
          file.write(open("http://www.yournavigation.org/api/1.0/gosmore.php?format=kml&flat=#{before.lat}&flon=#{before.lon}&tlat=#{@route.end_point.lat}&tlon=#{@route.end_point.lon}&v=motorcar&fast=1&layer=mapnik").read)
        end
      rescue
        errormessage "No connection to YOURS-Website possible"
      end
      
      #sets the filepath and the result to show errors
      @route.kml_path      = file_name_app+"?nocache"+Time.now.to_s
      @route.format = "KML"
      @route.save
      respond_to do |format|
        format.js {render :locals => {:format => "KML"}}
      end
      return
    
    when "energy"
      get_energy_route
    
    else
      puts @route.algorythm
    end

    #respond_to do |format|
    #  format.js
    #end
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
    url = "http://www.isp.uni-luebeck.de/greennav/green/route.action"
    
    #test xml
    xml = 
    
    "<?xml version=\"1.0\" encoding=\"UTF-8\"?>
<routingRequest ID=\"test\">
  <feature>routeCalculation</feature>
  <startNode>
    <geoCoords latitude=\"47.733333\"  longitude=\"10.316667\"/>
  </startNode>
  <targetNode>
    <geoCoords latitude=\"46.733333\"  longitude=\"9.316667\"/>
  </targetNode>
  <vehicleType>Karabag Fiat 500E</vehicleType>
  <optimization>ENERGY</optimization>
  <batteryChargeAtStart>75</batteryChargeAtStart>
  <resultType>geoCoords</resultType>
</routingRequest>"
    
    #
    #  "<routingRequest ID=\"test\">"+
    #  "<feature>routeCalculation</feature>"+
    #  "<startNode>"+
    #  "<geoCoords latitude=\"47.733333\" longitude=\"10.316667\"/>"+
    #  "</startNode>"+
    #  "<targetNode>"+
    #  "<geoCoords latitude=\"47.733433\" longitude=\"10.316567\"/>"+
    #  "</targetNode>"+
    #  "<vehicleType>STROMOS</vehicleType>"+
    #  "<batteryChargeAtStart>95</batteryChargeAtStart>"+
    #  "<resultType>geoCoords</resultType>"+
    #  "</routingRequest>"
    
   # xml = "<?xml version=\"1.0\" ?>"+
   #   "<S:Envelope xmlns:S=\"http://schemas.xmlsoap.org/soap/envelope/\">"+
   #   "<S:Body>"+
   #   "<ns2:createRoutingResponseXMLString xmlns:ns2=\"http://server.greennav.in.tum.de/\"><arg0>"+
   #     "&lt;?xml version=&quot;1.0&quot; encoding=&quot;UTF-8&quot;?&gt;"+
   #     "&lt;routingRequest ID=&quot;11:32:56 STROMOS 234&quot;&gt;"+
   #     "&lt;feature&gt;rangePrediction&lt;/feature&gt;"+
   #     "&lt;startNode&gt;"+
   #     "&lt;geoCoords latitude=&quot;47.733333&quot; longitude=&quot;10.316667&quot;/&gt;"+
   #     "&lt;/startNode&gt;"+
   #     "&lt;vehicleType&gt;STROMOS&lt;/vehicleType&gt;&lt;batteryChargeAtStart&gt;95&lt;/batteryChargeAtStart&gt;"+
   #     "&lt;resultType&gt;geoCoords&lt;/resultType&gt;"+
   #     "&lt;/routingRequest&gt;"+
   #   "</arg0></ns2:createRoutingResponseXMLString></S:Body></S:Envelope>"
puts "AAAAAAAAAAAAAA"
    @error = ""
    begin
      client = Savon::Client.new do
          wsdl.document = url
      end
puts "BBBBBBBBBBBBBB"


      #@res = client.request :wsdl, :create_routing_response_xml_string, "khkh" => @xml_doc
      @actions = client.wsdl.soap_actions
      @res = client.request "",:create_routing_response_xml_string do |soap|
        soap.xml = xml
      end
puts "CCCCCCCCCCCCCC"
      xml_string = @res.to_hash[:create_routing_response_xml_string_response][:return]
      coords = REXML::Document.new(xml_string)
      @result = "xml=="+coords.elements["routingResponse/nodes"].size.to_s
      #gets the result points
      nodes = get_points(coords.elements["routingResponse/nodes"])
      
puts "DDDDDDDDDDDDDDDD"
    rescue Exception => err
      puts "EEEEEEEEEEEEEEEEEE"
      @error = err.to_s
      p "error="+err.to_s
    end
    p "test="+@res.to_xml.to_s

    return nodes

  end


end
