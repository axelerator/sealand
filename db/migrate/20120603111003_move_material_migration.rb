class MoveMaterialMigration < ActiveRecord::Migration
  def change
    remove_column :materials, :latitude
    remove_column :materials, :longitude
    remove_column :materials, :accuracy
    add_column :locations, :material_id, :integer
  end
end
