class Fa37JncCHryDsbzayy4cBwDxS22JjzController < ApplicationController
  def index
    @user=Testuser.all
    @question=Test.all
  end
  
  def black
    @user2=Testuser.find_by_id(params[:param])
    @data=Testdata.find_all_by_testuser(params[:param])
    @result=Hash.new
    @data.each do |data|
      v=Test.find_by_id(data.task)
      @result.merge!({ data => v})
    end
    
  end
end
