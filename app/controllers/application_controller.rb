class ApplicationController < ActionController::Base
  protect_from_forgery

before_filter :set_locale
 
def set_locale
  if (!params[:locale].nil?)
    session[:language] = params[:locale]
  end
  if (session[:language].nil? || session[:language] == "")
    session[:language] = params[:locale]
  end
  I18n.locale = session[:language] || I18n.default_locale
end
  

def default_url_options(options={})
  #logger.debug "default_url_options is passed options: #{options.inspect}\n"
  { :locale => I18n.locale }
end

private 
  #get the current route of the session
  def current_route
    Route.find(session[:main_route])
  rescue ActiveRecord::RecordNotFound
    route = Route.create
    session[:main_route] = route.id
    route
  end
private

  def current_user
     Testuser.find(session[:testuser_id])
  rescue ActiveRecord::RecordNotFound
    testuser = Testuser.create
    session[:testuser_id] = testuser.id
    testuser
  end
  
  def errormessage(message)
    @message = message
    respond_to do |format|
      format.js
    end
  end
  
  def putr(message)
    errormessage(message)
  end
end
