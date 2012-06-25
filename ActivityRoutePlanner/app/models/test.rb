class Test < ActiveRecord::Base
  
  def self.next(id, lang)
    #logger.debug("===========================>"+Test.first(:conditions => ["id > ? AND test_language = ?", id, lang], :order => "id asc").to_s)
    Test.first(:conditions => ["id > ? AND test_language = ?", id, lang], :order => "id asc")
  end

end
