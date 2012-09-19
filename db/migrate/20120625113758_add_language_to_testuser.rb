class AddLanguageToTestuser < ActiveRecord::Migration
  def self.up
    add_column :testusers, :language, :string
  end

  def self.down
    remove_column :testusers, :language
  end
end
