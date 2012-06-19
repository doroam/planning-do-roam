class CreateTestdatas < ActiveRecord::Migration
  def self.up
    create_table :testdatas do |t|
      t.integer :testuser
      t.integer :task
      t.string :answer

      t.timestamps
    end
  end

  def self.down
    drop_table :testdatas
  end
end
