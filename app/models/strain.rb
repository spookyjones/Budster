class Strain < ActiveRecord::Base
	has_many :prices
	has_and_belongs_to_many :regions
	accepts_nested_attributes_for :prices 
	accepts_nested_attributes_for :regions
	
	def to_s
		name
	end
end
