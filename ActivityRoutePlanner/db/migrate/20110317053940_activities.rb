class Activities < ActiveRecord::Migration
  def self.up
    create_table :activities do |t|
      t.string :tag
      t.string :value
      t.references :route

      t.timestamps
    end
  end

  def self.down
  end
end
