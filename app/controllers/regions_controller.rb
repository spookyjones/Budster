class RegionsController < ApplicationController

	def index
		@regions = Region.all
	end
	
	def show
		@region = Region.find(params[:id])
		@prices = @region.prices
	end
	
	def most_popular_strain(state)
		state.group_by(:id).values.max_by(:strain).first
	end
end