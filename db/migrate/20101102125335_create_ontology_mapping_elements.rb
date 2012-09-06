class CreateOntologyMappingElements < ActiveRecord::Migration
  def self.up
    create_table :ontology_mapping_elements do |t|
      t.integer :ontology_mapping_id
      t.integer :source_id
      t.integer :target_id

      t.timestamps
    end

  end

  def self.down
    drop_table :ontology_mapping_elements
  end
end
