class Testuser < ActiveRecord::Base
  attr_accessible :name, :email, :home, :partner, :mother, :language, :feedback
end
