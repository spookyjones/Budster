class Strain < ActiveRecord::Base
	has_many :prices
	has_and_belongs_to_many :regions
	
	def to_s
		name
	end
end