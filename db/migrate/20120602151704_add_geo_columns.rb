class AddGeoColumns < ActiveRecord::Migration
  def up
    add_column :materials, :langitude, :float
    add_column :materials, :longitude, :float
    add_column :materials, :accuracy,  :float
  end

  def down
    remove_column :materials, :langitude
    remove_column :materials, :longitude
    remove_column :materials, :accuracy
  end
end
