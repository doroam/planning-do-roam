class AddEdgeEndLonToPoint < ActiveRecord::Migration
  def self.up
    add_column :points, :edge_end_lon, :string
  end

  def self.down
    remove_column :points, :edge_end_lon
  end
end
