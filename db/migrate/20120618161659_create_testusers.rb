class CreateTestusers < ActiveRecord::Migration
  def self.up
    create_table :testusers do |t|
      t.string :mother
      t.string :home
      t.string :partner

      t.timestamps
    end
  end

  def self.down
    drop_table :testusers
  end
end
