class Testdata < ActiveRecord::Base
  attr_accessible :task, :testuser, :answer
  belongs_to :testuser 
  belongs_to :test
#  has_many :testusers
#  has_many :tests
  
#  def initialize(task, user, query)
#    self.task = task
#    self.testuser = user
#    self.answer = query
#  end

end
