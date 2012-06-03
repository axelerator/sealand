
class Api::MaterialsController < ApplicationController

  # this is a very primitive approach and needs to be improved once we have more API consumers
  FIXED_API_KEY = 'f34df0fc602d1ef9d7a1ba8fa8a051fd17d6d2a1'

  DEFAULT_LIMIT, MAX_LIMIT = 10, 100

  respond_to :json

  before_filter :check_api_key

  # JSON response:
  # {
  #   "total": 2,
  #   "materials": [
  #     {
  #        "id": 23,
  #        "name": "Name of the material"
  #        "description": "Description of the material",
  #     },
  #     {
  #        "id": 42,
  #        "name": "Name of another material"
  #        "description": "Description of that material",
  #     }
  #   ]
  # }
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

  # Expected JSON input:
  #   {
  #     "material": {
  #       "name": "Material name",
  #       "description": "Description of the material"
  #     },
  #     "locations": [
  #       {
  #         "latitude": 13.1512,
  #         "longitude": 2.5125,
  #         "accuracy": 0.24,
  #         "description": "Description of location"
  #       }
  #     ]
  #   }
  # Response:
  # -  see Location header (i.e. /api/material/23)
  def create
    material = Material.new(params['material'])

    params['locations'].each do |location|
      material.locations.build(location)
    end

    if material.valid?
      material.save!
      head :created, :location => api_material_path(material.id)
    else
      render :status => :unprocessable_entity, :json => {
          "message" => "Please check your supplied fields"
        }
    end
  end

  # JSON response:
  #   {
  #      "id": 23,
  #      "name": "Name of the material"
  #      "description": "Description of the material",
  #   }
  def show
    if material = Material.find_by_id(param_as_int(params[:id]))
      render :json => material.attributes.slice('id', 'name', 'description')
    else
      render :status => :not_found, :json => { "message" => "Material not found" }
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
