class AddEdgeLatToPoint < ActiveRecord::Migration
  def self.up
    add_column :points, :edge_lat, :string
  end

  def self.down
    remove_column :points, :edge_lat
  end
end
