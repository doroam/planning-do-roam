class AddRepositoryUrlToGroups < ActiveRecord::Migration
  def self.up
    add_column :groups, :repository_url, :string
  end

  def self.down
    remove_column :groups, :repository_url
  end
end
