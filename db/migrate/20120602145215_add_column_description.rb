class AddColumnDescription < ActiveRecord::Migration
  def up
    add_column :materials, :description, :string, :default => ''
  end

  def down
    remove_column :materials, :description
  end
end
