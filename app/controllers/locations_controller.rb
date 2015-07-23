class LocationsController < ApplicationController
  
  def index
    if params[:s_slug] == nil
      @slug = ""
    else
      @slug = params[:s_slug].parameterize
    end
    @leafly = Vaporizer::Location.search( strainId: @slug, page: 0, take: 50, latitude: 47.607, longitude: -122.333)
    @stores = @leafly['stores']
  end
  
  def show
    @city = request.location.city
    @country = request.location.country_code
    @slug = params[:s_slug].parameterize
    @leafly = Vaporizer::Location.search( strainId: @slug, page: 0, take: 50, latitude: 47.607, longitude: -122.333)
    @stores = @leafly['stores']
  end
  
  def dispensary
    @menu = Vaporizer::Location.menu(params[:slug])
  end
  
end
