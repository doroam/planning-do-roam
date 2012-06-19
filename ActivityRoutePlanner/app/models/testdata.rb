class Testdata < ActiveRecord::Base
  has_many :testusers
  has_many :tests
  
  def initialize(task, user, query)
    self.task = task
    self.testuser = user
    self.answer = query
  end

end
