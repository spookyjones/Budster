class StrainsController < ApplicationController
	layout 'application'
	helper_method :sort_column, :sort_direction
	require 'json'
	
	def show
		@strain = Strain.find(params[:id])
		@prices = @strain.prices
		@leafly = Vaporizer::Strain.details(@strain.name.parameterize)
		@category = @leafly['category']
		@description = @leafly['description']
		@rating = @leafly['rating']
		@leaflyphotos = @leafly['photos'] #returns an array of hashes for each photo
		@starImage = @leafly['starImage'] #returns url
		@testgraph = @leafly['testGraph']
		@flavors2 = @leafly['flavors'] #returns an array of hashes for each flavor
			
		@key = @leafly["Key"]
	    @id = @leafly["Id"]
	    @symbol = @leafly["Symbol"]
	    @overview = @leafly["Overview"]
	    @url = @leafly["Url"]

	    @effects = @leafly["Effects"] #returns an array of hashes for each effect
	    @medical_uses = @leafly["Medical"]
	    @side_effects = @leafly["Negative"]
	    @reviews = @leafly["Reviews"]
		
	end
		
	def index
	    @strains = Strain.search(params[:search]).order(sort_column + " " + sort_direction).paginate(:per_page => 5, :page => params[:page])
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