class DisplayController < ApplicationController
  def index
    @user=Testuser.all
    #@data=Testdata.all
    
    #@result=Hash.new
    #@user.each do |users|
     # a=Array.new
      #@data.each do |datas|
	#if datas.testuser=users.id
	 # a.push(datas)
	#end
	
      #end
      #@result.merge!({users=>a})
    #end
    
  end
  
  def black
    
    @data=Testdata.find_all_by_testuser(params[:param])   
  end
    

end
