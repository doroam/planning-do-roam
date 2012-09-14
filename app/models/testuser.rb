class Testuser < ActiveRecord::Base
  attr_accessible :name, :email, :gender, :home, :partner, :mother, :language, :feedback
  has_many :testdatas, :foreign_key => "testuser"
end
