module StrainsHelper

	def make_thumb(data)
		@thumb2 = data['photos']
		@thumb3 = @thumb2[1]
		@thumb4 = @thumb3['thumb']
	end
	
	def strain_details(strain1)
		@details = Vaporizer::Strain.details(strain1.name.parameterize)
	end
  
  def average_strain(strain)
    total_prices = 0.0
    price_list = strain.prices.all
    price_list.each do |p|
      total_prices = total_prices + p.cost.to_i
    end
    avg = (total_prices / price_list.count) 
    avg == Float::NAN ? avg = 0 : avg
  end
  

end