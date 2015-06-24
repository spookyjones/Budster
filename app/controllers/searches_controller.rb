class SearchesController < ApplicationController
before_action :set_search
	def index
		@flavor_options = flavors
		@symptoms_options = symptoms
		@tag_options = tags
		@condtion_options = conditions
	end

	def search_leafly
		@db_strains = Strain.all
		@flavor_options = flavors
		@symptoms_options = symptoms
		@tag_options = tags
		@condtion_options = conditions
		#@search_results = Vaporizer::Strain.search(search: params[:s_slug], page: 0, take: 10)
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
		@take = params[:s_take] || 30
    	@slug = params[:s_slug] || ""
		@conditions = params[:s_conditions] || ""
		@flavors = params[:s_flavors] || ""
		@categories = params[:s_categories] || ""
		@symptoms = params[:s_symptoms] || ""
		@tags = params[:tags] || ""
      #@price.strain_id = Strain.find(params[:id].id
      #@price.region_id = Region.find(params[:id]).id
    end
	
	def search_params
		params.permit(:s_slug, :s_categories, :tags, :s_symptoms, :s_categories, :s_flavors, :s_conditions, :s_page)
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
		cond = ["", "anxious", "aroused", "creative", "dizzy", "dryeyes",
        "drymouth", "energetic", "euphoric", "focused", 
        "giggly", "happy", "hungry", "paranoid", "relaxed",
        "sleepy", "talkative", "tingly", "uplifted"]
	end
	
	
end
