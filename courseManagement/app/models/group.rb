class Group < ActiveRecord::Base
  has_many :users
  has_one :project
end
