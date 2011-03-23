class Word < ActiveRecord::Base
  # words for Wordnet
  # database fields:
  # wordid - primary key
  # lemma : character(80)
  
  has_many :senses # :finder_sql => 'SELECT * FROM senses WHERE senses.wordid = #{wordid}' # :primary_key => :wordid, :foreign_key => :wordid
  has_many :synsets, :through => :senses # , :primary_key => :wordid

  def synonyms
    self.synsets.map{|s| s.words}.flatten
  end

end