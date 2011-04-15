class Points < ActiveRecord::Migration
  def self.up
    create_table :points do |t|
      t.float :lat
      t.float :lon
      t.float :distance_source
      t.float :distance_target
      t.string :label
      t.string :icon
      t.references :activity

      t.timestamps
    end
  end

  def self.down
    drop_table :points
  end
end
