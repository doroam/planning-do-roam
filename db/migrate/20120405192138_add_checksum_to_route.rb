class AddChecksumToRoute < ActiveRecord::Migration
  def self.up
    add_column :routes, :checksum, :integer
  end

  def self.down
    remove_column :routes, :checksum
  end
end
