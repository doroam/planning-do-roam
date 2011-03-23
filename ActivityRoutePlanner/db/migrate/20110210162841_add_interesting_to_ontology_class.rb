class AddInterestingToOntologyClass < ActiveRecord::Migration
  def self.up
    add_column :ontology_classes, :interesting, :boolean
  end

  def self.down
    remove_column :ontology_classes, :interesting
  end
end
