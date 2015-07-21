module RegionsHelper
	def most_popular_strain(region)
		(region.prices.group(:strain_id).count.sort_by { |_,v| -v }.first || [1,1]).first
	end
  
  def average_region(region)
    total_prices = 0.0
    price_list = region.prices.all
    price_list.each do |p|
      total_prices = total_prices + p.cost.to_i
    end
    avg = (total_prices / price_list.count) 
    avg == Float::NAN ? avg = 0 : avg
  end
  
end