class DisplayController < ApplicationController
  def index
    @user=Testuser.all
    
  end
  
  def black
    @user2=Testuser.find_by_id(params[:param])
    @data=Testdata.find_all_by_testuser(params[:param])   
  end
    

end
