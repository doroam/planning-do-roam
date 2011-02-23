class InitController < ApplicationController
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml }
    end
  end

end
