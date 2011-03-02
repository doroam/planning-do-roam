class AlgorithmusController < ApplicationController
  
  def setAlgorithmus
    route = session[:main_route]
    a = params[:algo]
    
    if a != nil    
      route.algorithmus.set_algorithmus a       
      session[:main_route] = route
    end  

    respond_to do |format|      
      format.js
    end    
  end
end
