class Region < ActiveRecord::Base
	has_many :prices
	has_many :strains, :through => :prices
	accepts_nested_attributes_for :strains
	accepts_nested_attributes_for :prices
	def to_s
		name
	end

	
end
