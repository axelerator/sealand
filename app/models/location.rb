class Location < ActiveRecord::Base
  belongs_to :material

  validates_numericality_of :latitude
  validates_numericality_of :longitude
  validates_numericality_of :accuracy

  attr_accessible :latitude, :longitude, :accuracy, :description
end
