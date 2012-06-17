class Test < ActiveRecord::Base
  
  def self.next(id)
    Test.first(:conditions => ["id > ?", id], :order => "id asc")
  end

end
