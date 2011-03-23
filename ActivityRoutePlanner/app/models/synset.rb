class Synset < ActiveRecord::Base
  # sets of synonyms for Wordnet
  # database fields:
  # sysnsetid  - primary key
  # pos : character(1)
  # lexdomainid
  # definition : text


  has_many :senses # , :foreign_key => :synsetid, :primary_key => :synsetid
  has_many :words, :through => :senses
  belongs_to :lexdomain, :foreign_key => :lexdomainid

end