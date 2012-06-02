
class Api::MaterialsController < ApplicationController

  # this is a very primitive approach and needs to be improved once we have more API consumers
  FIXED_API_KEY = 'f34df0fc602d1ef9d7a1ba8fa8a051fd17d6d2a1'

  DEFAULT_LIMIT, MAX_LIMIT = 10, 100

  respond_to :json

  before_filter :check_api_key

  def index
    limit  = [param_as_int(params['limit']) || DEFAULT_LIMIT, MAX_LIMIT].min
    offset = param_as_int params['offset'] || 0

    materials = Material.all(:limit => limit, :offset => offset)

    result = materials.map do |material|
      material.attributes.slice('name', 'description', 'id')
    end

    render :json => {
      'total' => Material.count,
      'materials' => result
    }
  end

  def create
    material = Material.new
    material.assign_attributes(params['material'])
    material.assign_attributes(params['location'])

    if material.valid?
      material.save!
      head :created
    else
      render :status => :unprocessable_entity, :json => {
          "message" => "Please check your supplied fields"
        }
    end
  end

  private

  def param_as_int(param_or_nil)
    param_or_nil.blank? ? nil : param_or_nil.to_i
  end

  def check_api_key
    unless request.headers['Authorization'] == "api_key=#{FIXED_API_KEY}"
      render :status => :unauthorized, :json => {
         "message" => "Unauthorized. Please check you API key."
      }
    end
  end

end
