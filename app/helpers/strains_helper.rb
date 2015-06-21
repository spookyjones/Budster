module StrainsHelper
	def thumb_of_strain(strain1)
		@leafly2 = Vaporizer::Strain.photos(strain1.name, { page: 0, take: 2 })
		@leafly3 = @leafly2['photos']
		@leafly4 = @leafly3[1]
		@leafly4['thumb'].html_safe
	end
end