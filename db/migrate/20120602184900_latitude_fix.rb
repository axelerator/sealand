class LatitudeFix < ActiveRecord::Migration
  def change
    rename_column :materials, :langitude, :latitude
  end
end
