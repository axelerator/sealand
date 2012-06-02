class Material < ActiveRecord::Base
  validates_presence_of :name

  attr_accessible :name, :description, :langitude, :longitude, :accuracy
end
