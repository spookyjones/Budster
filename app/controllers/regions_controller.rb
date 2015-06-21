class RegionsController < ApplicationController

	def index
		@regions = Region.all
		@prices = Price.all
		@strains = Strain.all
	end
	
	def show
		@region = Region.find(params[:id])
		@prices = @region.prices
	end
	

end