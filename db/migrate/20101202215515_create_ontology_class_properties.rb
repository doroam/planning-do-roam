class CreateOntologyClassProperties < ActiveRecord::Migration
  def self.up
    create_table :ontology_class_properties do |t|
      t.integer :concept
      t.string :property
      t.string :term

      t.timestamps
    end
  end

  def self.down
    drop_table :ontology_class_properties
  end
end
