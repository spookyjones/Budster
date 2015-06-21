module ApplicationHelper
	def sortable(column, title = nil)
		title ||= column.titleize
		css_class = column == sort_column ? "current #{sort_direction}" : nil
		direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
		link_to title, params.merge(:sort => column, :direction => direction, :page => nil), {:class => css_class}	
	end
	
	def most_popular_strain(region)
	
		strainlist = []
		
		region.prices.each do |p|
			strainlist << p.strain_id
		end
		
		freq = strainlist.inject(Hash.new(0)) { |h,v| h[v] += 1; h }
		strainlist.max_by { |v| freq[v] }
		
	end
	
end
