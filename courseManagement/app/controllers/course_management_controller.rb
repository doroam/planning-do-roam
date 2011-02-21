class CourseManagementController < ApplicationController
  def index
    @testvar = "testa"
	end
  def new
    @title = "Sign in uhuh"
    @testvar = "testsaaa"
  end
  def create
    @success = false
    
    User.all.each do |user|
      @testvar = "buaaaa"
      if user.login.eql? params[:login]
        flash.now[:error] = "Invalid email/password combination."
        @title = "Sign in"
        redirect_to :users
      end
    end
    @testvar = "testsaaa2"
    redirect_to :back
  end
end
