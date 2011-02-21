class ProfessorViewController < ApplicationController
  def index
    @tree = Hash.new

   User.all.each do |user|
    Group.all.each do |group|
      @list = @tree[group]
      if @list == nil
        @list = Array.new
      end
      @list.push(user)
      @tree.store(group,@list)
      end
    end
    
	end
end
