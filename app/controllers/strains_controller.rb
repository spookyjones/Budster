class StrainsController < ApplicationController
	layout 'application'
	helper_method :sort_column, :sort_direction
	require 'json'
	
	def show
		@strain = Strain.find(params[:id])
		@prices = @strain.prices
		@leafly = Vaporizer::Strain.details(@strain.name.parameterize)
		@description = @leafly['description']
		@leafly2 = Vaporizer::Strain.photos(@strain.name.parameterize, { page: 0, take: 8 })
		@leafly3 = @leafly2['photos']
		@leaflyphotos = @leafly3#['thumb']
	end
		
	def index
	    @strains = Strain.search(params[:search]).order(sort_column + " " + sort_direction).paginate(:per_page => 10, :page => params[:page])
	end
	
	def new
		@strain = Strain.new
	end
	
	def sort_column
      Strain.column_names.include?(params[:sort]) ? params[:sort] : "created_at"
    end
    
    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
    end
end