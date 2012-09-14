class AddFormatToRoute < ActiveRecord::Migration
  def self.up
    add_column :routes, :format, :string
  end

  def self.down
    remove_column :routes, :format
  end
end
