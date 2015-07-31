class LocationsController < ApplicationController

  before_action :set_search, :only => [:index, :show]

  def index
  end
  
  def show
  end
  
  def details
    @details = Vaporizer::Location.details(params[:slug])
    @name = @details['name']
    @atm = @details['atm']
    @credit_cards = @details['creditCards']
    @veteran_discount = @details['veteranDiscount']
    @blurb = @details['blurb']
    @rating = @details['rating']
    @storefront = @details['storefront']
    @meds = @details['meds']
    @service = @details['service']
    @atmosphere = @details['atmosphere']
    @follower_count = @details['followerCount']
    @review_count = @details['reviewCount']
    @facebook_url = @details['facebookUrl']
    @twitter_url = @details['twitterUrl']
    @google_plus_url = @details['googlePlusUrl']
    @pinterest_url = @details['pinterestUrl']
    @tumblr_url = @details['tumblrUrl']
    @instagram_url = @details['instagramUrl']
    @recent_reviews = @details['recentReviews']
    @updates = @details['updates']
    @specials = @details['specialsList']
    @hours = @details['hours']
    @website = @details['website']
    @city = @details['city']
    @state = @details['state']
    @zip = @details['zip']
    @medical = @details['medical']
    @delivery = @details['delivery']
    @retail = @details['retail']
    @photos = @details['photos']
    @hours = @details['hours']
    @address1 = @details['address1']
    @phone = @details['phone']
  end
  
  def dispensary
    @menu = Vaporizer::Location.menu(params[:slug])
  end
  
  def specials
    @specials = Vaporizer::Location.specials(params[:slug])
  end
    
	private
	
    def set_search
      if params[:address] == nil 
        @a=Geokit::Geocoders::GoogleGeocoder.geocode 'Los Angeles, CA'
      else
        @a=Geokit::Geocoders::GoogleGeocoder.geocode params[:address]
      end
      
      if params[:s_slug] == nil
        @slug = ""
      else
        @slug = params[:s_slug]
      end
      
      @leafly = Vaporizer::Location.search( strainId: @slug, page: 0, take: 50, latitude: @a.lat, longitude: @a.lng, delivery: params[:delivery], retail: params[:retail], medical: params[:medical] )
      @stores = @leafly['stores'] 
    end
  
end
