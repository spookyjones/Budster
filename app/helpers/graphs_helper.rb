module GraphsHelper
	
	def avg_price_month(start, stop)
		total = 0.00
		@last_price = Price.where("created_at > ? AND created_at < ?", start, stop ) 
		@last_price.each do |n| 
			@total = @total.to_f + n.cost.to_f 
		end 
		(@total.to_f / @last_price.count.to_f)
	end
	
end
