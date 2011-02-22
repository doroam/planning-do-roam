class CourseManagementController < ApplicationController
  def index
	end
  def new
    flash[:errorMessage] = ""
  end
  def create
    @success = false

    User.all.each do |user|
      if user.login.eql? params["login"]["login"]
        @success = true
        @user = user
      end
    end
    
    if @success
      session[:login_user] = @user
      if @user.is_professor
        #render(professor_view_url, :action => "show")
        redirect_to :professor_view
      else
        redirect_to "/studi_groups_view_url"
      end
    else      
      flash[:errorMessage] = "Benutzername nicht gefunden."
      redirect_to :back
    end
  end
end
