module SearchesHelper

	def next_page
		@page += 1
	end
	
	def back_page
	    @page = 0 || @page -= 1 
	end
	
end
