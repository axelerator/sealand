class Workshop < ActiveRecord::Base
  attr_accessible :description, :lat, :lng, :name, :plan_id, :user_id
  belongs_to :user # the user that created the workshop
  belongs_to :plan # the plan this workshop uses
end
