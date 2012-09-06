class ContentLoaderController < ApplicationController
  def load_content
    #loads a content
    respond_to do |format|
      format.js
    end
  end
end
