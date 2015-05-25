class RegionsController < ApplicationController
	def show
		@region = Region.find(params[:id])
		@prices = @region.prices
	end
end