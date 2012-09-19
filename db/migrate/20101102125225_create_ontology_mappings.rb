class CreateOntologyMappings < ActiveRecord::Migration
  def self.up
    create_table :ontology_mappings do |t|
      t.string :name
      t.integer :source_id
      t.integer :target_id

      t.timestamps
    end
  end

  def self.down
    drop_table :ontology_mappings
  end
end
