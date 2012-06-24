class Testdata < ActiveRecord::Base
  attr_accessor :task, :testuser, :answer
#  has_many :testusers
#  has_many :tests
  
  def initialize(task, user, query)
    self.task = task
    self.testuser = user
    self.answer = query
    self.save
  end

end
