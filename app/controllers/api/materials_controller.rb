
class Api::MaterialsController < ApplicationController

  # this is a very primitive approach and needs to be improved once we have more API consumers
  FIXED_API_KEY = 'f34df0fc602d1ef9d7a1ba8fa8a051fd17d6d2a1'

  respond_to :json

  before_filter :check_api_key

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

  private

  def check_api_key
    unless request.headers['Authorization'] == "api_key=#{FIXED_API_KEY}"
      render :json => '{"message": "Unauthorized. Please check you API key."}', :status => :unauthorized
    end
  end

end
