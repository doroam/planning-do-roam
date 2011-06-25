class AddEdgeLonToPoint < ActiveRecord::Migration
  def self.up
    add_column :points, :edge_lon, :string
  end

  def self.down
    remove_column :points, :edge_lon
  end
end
