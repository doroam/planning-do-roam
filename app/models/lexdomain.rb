class Lexdomain < ActiveRecord::Base
  # lexdomains for Wordnet
  # database fields:
  # lexdomainid  - primary key
  # lexdomainname : character(32)
  # pos : character(1)


  has_many :synsets, :foreign_key => :lexdomainid

end