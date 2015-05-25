class Strain < ActiveRecord::Base
	has_many :prices
	
	def to_s
		name
	end
end
