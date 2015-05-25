class StrainsController < ApplicationController
	def show
		@strain = Strain.find(params[:id])
		@prices = @strain.prices
	end
end