class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :login
      t.string :name
      t.references :group
      t.boolean :is_professor

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
