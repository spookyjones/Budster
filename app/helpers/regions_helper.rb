module RegionsHelper
	def most_popular_strain(region)
		(region.prices.group(:strain_id).count.sort_by { |_,v| -v }.first || [1,1]).first
	end
end