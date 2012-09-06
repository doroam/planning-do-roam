class CreateOntologySubclasses < ActiveRecord::Migration
  def self.up
    create_table :ontology_subclasses do |t|
      t.integer :subclass_id
      t.integer :superclass_id

      t.timestamps
    end
  end

  def self.down
    drop_table :ontology_subclasses
  end
end
