class ActivityController < ApplicationController
  
  def updateActivity
    route = session[:main_route]
           
       
    respond_to do |format|      
      format.js 
    end
  end
end