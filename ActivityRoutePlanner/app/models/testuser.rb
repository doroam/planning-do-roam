class Testuser < ActiveRecord::Base
  attr_accessible :name, :email, :gender, :home, :partner, :mother, :language, :feedback
end
