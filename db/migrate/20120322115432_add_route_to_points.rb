class AddRouteToPoints < ActiveRecord::Migration
  def self.up
    add_column :points, :route_id, :integer
  end

  def self.down
    remove_column :points, :route_id
  end
end
