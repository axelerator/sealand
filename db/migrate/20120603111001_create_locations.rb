class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.float :latitude
      t.float :longitude
      t.float :accuracy
      t.string :description
      t.timestamps
    end
  end
end
