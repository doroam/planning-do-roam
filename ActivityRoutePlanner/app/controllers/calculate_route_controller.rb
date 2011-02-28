class CalculateRouteController < ApplicationController
  def check_edge
    route = session[:main_route]
    result = RouteGenerator.generate_route(route);
    
    res = XmlGenerator.generate_route(result)
    params[:kml] = res
    File.open("public/kmlRoute.kml", 'w') {|f| f.write(res) }
    
    respond_to do |format|
      format.js
    end
  end
end
