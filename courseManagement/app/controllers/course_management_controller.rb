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
      if @user.is_professor
        #render(professor_view_url, :action => "show")
        redirect_to professor_view_url
      else
        redirect_to :groups
      end
    else      
      flash[:errorMessage] = "Benutzername nicht gefunden."
      redirect_to :back
    end
  end
end
