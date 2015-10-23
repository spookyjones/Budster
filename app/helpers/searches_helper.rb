module SearchesHelper

	def next_page
		@page += 1
	end
	
	def back_page
	    @page = 0 || @page -= 1 
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
  
  def strain_from_slug(slug)
    @strain = Strain.find_or_create_by({name: slug.parameterize })
  end
  
end
