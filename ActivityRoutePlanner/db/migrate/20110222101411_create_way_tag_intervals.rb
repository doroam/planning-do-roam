class CreateWayTagIntervals < ActiveRecord::Migration
  def self.up
    create_table :way_tag_intervals do |t|
      t.integer :way_tag_id
      t.integer :interval_id

      t.timestamps
    end
  end

  def self.down
    drop_table :way_tag_intervals
  end
end
