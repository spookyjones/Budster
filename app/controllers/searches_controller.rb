class SearchesController < ApplicationController
before_action :set_search
	def index
		
	end
	
	def search_leafly
		
		#@search_results = Vaporizer::Strain.search(search: params[:s_slug], page: 0, take: 10)
		@search_results = Vaporizer::Strain.search(
    	filters: {
		tags: [@tags],
		symptoms: [@symptoms],
		category: [@categories],
		flavors: [@flavors],
		conditions: [@conditions] },
		search: @slug,
		page: 0, take: 10
		)
	end
	
	private
	
    def set_search
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
		params.permit(:s_slug, :s_categories, :tags, :s_symptoms, :s_categories, :s_flavors, :s_conditions)
	end
	
end
