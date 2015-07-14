class SearchesController < ApplicationController
before_action :set_search
	def index
		@flavor_options = flavors
		@symptoms_options = symptoms
		@tag_options = tags
		@condtion_options = conditions
	end
	
	def show
		
		@strain_params = params[:s_slug] || "unknown"
    	@strain = Strain.find_or_create_by(name: @strain_params)
    	@region_options = Region.all.map{|r| [ r.name, r.id ] }
    	@price = Price.new
    	@price.strain = @strain
		@flavor_options = flavors
		@symptoms_options = symptoms
		@tag_options = tags
		@leafly = Vaporizer::Strain.details(params[:s_slug])
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
		@negatives = @leafly['negativeEffects']
		@permalink = @leafly['permalink']
		@relatedstrains = @leafly['relatedStrains']#returns an array of hashes
		@parents = @leafly['parents']#returns an array of hashes
	    @reviews = @leafly["highlightedReviews"]#returns an array of hashes
		@video = @leafly['videoUrl']
	end
	
	def search_leafly
		@db_strains = Strain.all
		@flavor_options = flavors
		@symptoms_options = symptoms
		@tag_options = tags
		@condtion_options = conditions
		@search_results = Vaporizer::Strain.search(
			filters: {
			tags: [@tags],
			symptoms: [@symptoms],
			category: [@categories],
			flavors: [@flavors],
			conditions: [@conditions] },
			search: @slug,
			page: @page, take: @take
			)

		@strain_results = @search_results['Strains']

	end
	
	private
	
    def set_search
		@page = params[:s_page] || 0
		@take = params[:s_take] || 15
    	@slug = params[:s_slug] || ""
		@conditions = params[:s_conditions] || ""
		@flavors = params[:s_flavors] || ""
		@categories = params[:s_categories] || ""
		@symptoms = params[:s_symptoms] || ""
		@tags = params[:tags] || ""
    end
	
	def search_params
		params.permit(:s_slug, :s_categories, :tags, :s_effects, :s_symptoms, :s_categories, :s_flavors, :s_conditions, :s_page)
	end
	
	def flavors
		flavs = ["", "ammonia", "apple", "apricot",
		"berry", "bluecheese", "blueberry",
		"butter", "cheese", "chemical",
		"chestnut", "citrus", "coffee",
		"diesel", "earthy", "flowery",
		"grape", "grapefruit", "honey",
		"lavender", "lemon", "lime",
		"mango", "menthol", "mint",
		"minty", "nutty", "orange",
		"peach", "pear", "pepper", "pine",
		"pineapple", "plum", "pungent", 
		"rose", "sage", "skunk", 
		"spicyherbal", "strawberry", 
		"sweet", "tar", "tea", "tobacco", 
		"treefruit", "tropical", "vanilla",
		"violet", "woody" ]
	end
	
	def symptoms
		sympt = ["", "cramps", "depression", "eyepressure", 
		"fatigue", "headaches", "inflammation",
		"insomnia", "lackofappetite", "musclespasms",
		"nausea", "pain", "seizures", "spasticity",
		"stress"]
	end
	
	def tags
		tag = ["", "anxious", "aroused", "creative", "dizzy", "dryeyes",
		"drymouth", "energetic", "euphoric", "focused", 
		"giggly", "happy", "hungry", "paranoid", "relaxed",
		"sleepy", "talkative", "tingly", "uplifted"]
	end
	
	def conditions
		cond = ["", "addadhd", "alzheimers", "anorexia", "anxiety",
		"arthritis", "asthma", "bipolardisorder", "cachexia", "cancer",
		"crohnsdisease", "epilepsy", "fibromyalgia", "glaucoma", 
		"hivaids", "hypertension", "migraines", "multiplesclerosis", 
		"musculardystrophy", "parkinsons", "phantomlimbpain", "pms", "ptsd", 
		"spinalcordinjury", "tinnitus", "tourettessyndrome"]
	end
	
	
end
