class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :login
      t.string :name
      t.boolean :is_professor
      t.references :group

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
