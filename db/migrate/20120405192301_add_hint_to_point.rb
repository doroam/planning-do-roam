class AddHintToPoint < ActiveRecord::Migration
  def self.up
    add_column :points, :hint, :integer
  end

  def self.down
    remove_column :points, :hint
  end
end
