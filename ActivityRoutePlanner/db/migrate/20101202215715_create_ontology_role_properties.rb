class CreateOntologyRoleProperties < ActiveRecord::Migration
  def self.up
    create_table :ontology_role_properties do |t|
      t.integer :role
      t.string :property
      t.string :term

      t.timestamps
    end
  end

  def self.down
    drop_table :ontology_role_properties
  end
end
