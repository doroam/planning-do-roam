class AddGenderToTestuser < ActiveRecord::Migration
  def self.up
    add_column :testusers, :gender, :string
  end

  def self.down
    remove_column :testusers, :gender
  end
end
