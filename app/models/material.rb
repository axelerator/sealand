class Material < ActiveRecord::Base
  validates_presence_of :name
  validates_presence_of :description
  validates_numericality_of :langitude
  validates_numericality_of :longitude
  validates_numericality_of :accuracy

  attr_accessible :name, :description, :langitude, :longitude, :accuracy
end
