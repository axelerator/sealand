class Plan < ActiveRecord::Base
  attr_accessible :description, :name, :user_id
  belongs_to :user
  has_file :plan_image, PlanImageUploader
  has_many :workshops
end
