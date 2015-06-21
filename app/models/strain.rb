class Strain < ActiveRecord::Base
	has_many :prices, -> { order(position: :asc) }
	has_and_belongs_to_many :regions
	accepts_nested_attributes_for :prices 
	accepts_nested_attributes_for :regions
	acts_as_list
	def to_s
		name
	end
	
	def self.search(search)
	  if search
	    where('name LIKE ?', "%#{search}%")
	  else
	    all
	  end
	end
end
