class AddNameAndMailToTestusers < ActiveRecord::Migration
  def self.up
    add_column :testusers, :name, :string
    add_column :testusers, :email, :string
  end

  def self.down
    remove_column :testusers, :email
    remove_column :testusers, :name
  end
end
