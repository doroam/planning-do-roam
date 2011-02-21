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
        redirect_to :professor_view
      else
        redirect_to :users
      end
    else      
      flash[:errorMessage] = "Benutzername nicht gefunden."
      redirect_to :back
    end
  end
end
