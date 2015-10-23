class StrainsController < ApplicationController
	layout 'application'
	helper_method :sort_column, :sort_direction
	require 'json'

	def show
		@strain = Strain.find(params[:id])
		@prices = @strain.prices
    @price = Price.new
    @region_options = Region.all.map{|r| [ r.name, r.id ] }
		@leafly = Vaporizer::Strain.details(@strain.name.parameterize)
		@category = @leafly['category']
		@description = @leafly['description']
		@rating = @leafly['rating']
		@leaflyphotos = @leafly['photos'] #returns an array of hashes for each photo
		@starImage = @leafly['starImage'] #returns url
		@testgraph = @leafly['testGraph']#returns url
		@flavors = @leafly['flavors'] #returns an array of hashes for each flavor
		@effects = @leafly['effects']#returns an array of hashes
		@symptoms = @leafly['symptoms']	#returns an array of hashes
		@conditions = @leafly['conditions']#returns an array of hashes
		@growinfo = @leafly['growInfo']
		@permalink = @leafly['permalink']
		@relatedstrains = @leafly['relatedStrains']#returns an array of hashes
		@parents = @leafly['parents']#returns an array of hashes
	  @reviews = @leafly["highlightedReviews"]#returns an array of hashes
		@video = @leafly['videoUrl']
  rescue Vaporizer::NotFound
      
	end

	def index
	    @strains = Strain.search(params[:search]).order(sort_column + " " + sort_direction).paginate(:per_page => 5, :page => params[:page])
	end

	def create
		@strain = Strain.new
	end

	def sort_column
      Strain.column_names.include?(params[:sort]) ? params[:sort] : "created_at"
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
    end


end