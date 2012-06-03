class Material < ActiveRecord::Base
  validates_presence_of :name
  validates_presence_of :description

  has_many :locations

  attr_accessible :name, :description
end
