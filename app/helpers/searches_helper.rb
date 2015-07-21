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
    (total_prices / price_list.count)
  end
  
  
  
end
