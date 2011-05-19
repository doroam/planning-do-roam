class CreateRoutes < ActiveRecord::Migration
  def self.up
    create_table :routes do |t|
      t.string :algorithmus
      t.string :sort
      t.string :kml_path
      t.string :optimization
      t.string :car_type
      t.float :charge
      t.integer :start_point_id
      t.integer :end_point_id

      t.timestamps
    end
  end

  def self.down
    drop_table :routes
  end
end
