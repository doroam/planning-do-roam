class AddEdgeEndLatToPoint < ActiveRecord::Migration
  def self.up
    add_column :points, :edge_end_lat, :string
  end

  def self.down
    remove_column :points, :edge_end_lat
  end
end
