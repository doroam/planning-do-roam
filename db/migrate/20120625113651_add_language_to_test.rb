class AddLanguageToTest < ActiveRecord::Migration
  def self.up
    add_column :tests, :test_language, :string
  end

  def self.down
    remove_column :tests, :test_language
  end
end
