class CreateTests < ActiveRecord::Migration
  def self.up
    create_table :tests do |t|
      t.text :task
      t.string :screen_question
      t.string :screen_solution

      t.timestamps
    end
  end

  def self.down
    drop_table :tests
  end
end
