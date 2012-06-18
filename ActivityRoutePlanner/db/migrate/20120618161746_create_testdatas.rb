class CreateTestdatas < ActiveRecord::Migration
  def self.up
    create_table :testdatas do |t|
      t.int :testuser
      t.int :task
      t.string :answer

      t.timestamps
    end
  end

  def self.down
    drop_table :testdatas
  end
end
