class Region < ActiveRecord::Base
	has_many :prices
	has_and_belongs_to_many :strains
	
	def to_s
		name
	end
end
