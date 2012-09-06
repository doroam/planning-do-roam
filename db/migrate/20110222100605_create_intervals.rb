class CreateIntervals < ActiveRecord::Migration
  def self.up
    create_table :intervals do |t|
      t.integer :start
      t.integer :stop

      t.timestamps
    end
  end

  def self.down
    drop_table :intervals
  end
end
