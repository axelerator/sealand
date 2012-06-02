class CreateWorkshops < ActiveRecord::Migration
  def change
    create_table :workshops do |t|
      t.string :name
      t.text :description
      t.integer :user_id
      t.float :lat
      t.float :lng
      t.integer :plan_id

      t.timestamps
    end
  end
end
