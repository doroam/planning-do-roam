class CreateNodeTagIntervals < ActiveRecord::Migration
  def self.up
    create_table :node_tag_intervals do |t|
      t.integer :node_tag_id
      t.integer :interval_id

      t.timestamps
    end
  end

  def self.down
    drop_table :node_tag_intervals
  end
end
