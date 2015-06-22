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
		@flavors = @leafly['flavors'] #returns an array of hashes for each flavor
		@effects = @leafly['effects']
		@symptoms = @leafly['symptoms']	
		@conditions = @leafly['conditions']
		@grofinfo = @leafly['growInfo']
		@permalink = @leafly['permalink']
		@relatedstrains = @leafly['relatedStrains']
		@parents = @leafly['parents']
	    @reviews = @leafly["highlightedReviews"]
		@video = @leafly['videoUrl']
		
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