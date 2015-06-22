module StrainsHelper

	def make_thumb(data)
		@thumb2 = data['photos']
		@thumb3 = @thumb2[1]
		@thumb4 = @thumb3['thumb']
	end
	
	def strain_details(strain1)
		@details = Vaporizer::Strain.details(strain1.name.parameterize)
	end
		

end