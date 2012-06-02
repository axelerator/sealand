
class Api::MaterialsController < ApplicationController

  respond_to :json

  def create
    material = Material.new
    material.assign_attributes(params['material'])
    material.assign_attributes(params['location'])

    if material.valid?
      material.save!
      head :created
    else
      render :json => '{"message": "Please check your supplied fields"}', :status => :unprocessable_entity
    end
  end

end
