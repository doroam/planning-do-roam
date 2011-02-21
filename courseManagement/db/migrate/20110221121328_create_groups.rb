class CreateGroups < ActiveRecord::Migration
  def self.up
    create_table :groups do |t|
      t.string :name
      t.integer :user_one_id
      t.integer :user_two_id
      t.timestamps
    end
  end

  def self.down
    drop_table :groups
  end
end
