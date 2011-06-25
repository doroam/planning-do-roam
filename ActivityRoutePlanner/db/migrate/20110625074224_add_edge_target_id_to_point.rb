class AddEdgeTargetIdToPoint < ActiveRecord::Migration
  def self.up
    add_column :points, :edgeTargetID, :integer
  end

  def self.down
    remove_column :points, :edgeTargetID
  end
end
