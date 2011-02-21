class UpdateDb < ActiveRecord::Migration
  def self.up
	  add_column :users,:user_one_id,:integer
	  add_column :users,:user_two_id,:integer
  end

  def self.down
  end
end
