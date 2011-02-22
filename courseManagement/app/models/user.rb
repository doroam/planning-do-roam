class User < ActiveRecord::Base
  validates_presence_of :name
  validates_presence_of :login
  belongs_to :group
end
