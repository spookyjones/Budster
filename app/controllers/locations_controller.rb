class LocationsController < ApplicationController
  before_action :set_search
  def index

  end
  
  def show

  end
  
  def dispensary
    @menu = Vaporizer::Location.menu(params[:slug])
  end
  
  
	private
	
    def set_search
      if params.has_key?(:address) then
        @a=Geokit::Geocoders::GoogleGeocoder.geocode params[:address]
      else
        @a=Geokit::Geocoders::GoogleGeocoder.geocode 'Los Angeles, CA'
      end
      
      if params[:s_slug] == nil
        @slug = ""
      else
        @slug = params[:s_slug]
      end
      
      @leafly = Vaporizer::Location.search( strainId: @slug, page: 0, take: 50, latitude: @a.lat, longitude: @a.lng )
      @stores = @leafly['stores'] 
    end
  
end
