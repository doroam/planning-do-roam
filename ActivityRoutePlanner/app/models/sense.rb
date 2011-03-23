class Sense < ActiveRecord::Base
  # senses of words for Wordnet
  # database fields:
  # wordid
  # casedwordid
  # synsetid
  # senseid
  # sensenum
  # lexid
  # tagcount
  # sensekey


  belongs_to :word # , :foreign_key => :wordid, :primary_key => :wordid
  belongs_to :synset # , :foreign_key => :synsetid, :primary_key => :synsetid

end