class AddPlanImageToPlan < ActiveRecord::Migration
  def change
    add_column :plans, :plan_image, :string
  end
end
