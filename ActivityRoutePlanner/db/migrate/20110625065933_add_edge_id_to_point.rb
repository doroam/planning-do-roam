class AddEdgeIdToPoint < ActiveRecord::Migration
  def self.up
    add_column :points, :edgeID, :integer
  end

  def self.down
    remove_column :points, :edgeID
  end
end
