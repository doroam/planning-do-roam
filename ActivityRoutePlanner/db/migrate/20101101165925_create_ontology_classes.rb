class CreateOntologyClasses < ActiveRecord::Migration
  def self.up
    create_table :ontology_classes do |t|
      t.string :name
      t.integer :ontology_id

      t.timestamps
    end
  end

  def self.down
    drop_table :ontology_classes
  end
end
