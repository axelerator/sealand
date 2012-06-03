class Attachment < ActiveRecord::Base
  attr_accessible :name, :plan_attachment, :plan_id, :user_id
  validates :name,  :presence => true
  validates :plan_attachment,  :presence => true
  has_file :plan_attachment, PlanAttachmentUploader
  belongs_to :user # the user that uploaded the attachment
  belongs_to :plan # the plan for which this attachment was uploaded 
end
