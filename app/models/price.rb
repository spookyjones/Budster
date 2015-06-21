class Price < ActiveRecord::Base
	belongs_to :strain
	validates_presence_of :cost
	belongs_to :region
	accepts_nested_attributes_for :strain
	accepts_nested_attributes_for :region
	acts_as_list 
	
	scope :sorted, lambda { order("prices.position ASC") }
	scope :newest_first, lambda { order("prices.created_at DESC")}



end
