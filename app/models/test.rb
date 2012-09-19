class Test < ActiveRecord::Base
  has_many :testdatas, :foreign_key => "task"
  
  def self.next(id, lang)
    #logger.debug("===========================>"+Test.first(:conditions => ["id > ? AND test_language = ?", id, lang], :order => "id asc").to_s)
    Test.first(:conditions => ["id > ? AND test_language = ?", id, lang], :order => "id asc")
  end

end
