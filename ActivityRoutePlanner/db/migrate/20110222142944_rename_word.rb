class RenameWord < ActiveRecord::Migration
  def self.up

   rename_column(:words, :wordid, :id)
   rename_column(:senses, :wordid, :word_id)
   rename_column(:senses, :synsetid, :synset_id)
   rename_column(:synsets, :synsetid, :id)

  end

  def self.down
  end
end
