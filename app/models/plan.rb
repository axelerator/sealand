class Plan < ActiveRecord::Base
  attr_accessible :description, :name, :user_id, :plan_image
  belongs_to :user
  has_file :plan_image, PlanImageUploader
  has_many :workshops
end
