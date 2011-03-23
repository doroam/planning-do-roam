class CreateOntologyroles < ActiveRecord::Migration
  def self.up
    create_table :ontologyroles do |t|
      t.string :name
      t.string :domain
      t.string :range

      t.timestamps
    end
  end

  def self.down
    drop_table :ontologyroles
  end
end
