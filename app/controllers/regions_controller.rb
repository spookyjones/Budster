class RegionsController < ApplicationController

	def index
	end
	
	def show
		@region = Region.find(params[:id])
		@prices = @region.prices
	end
end