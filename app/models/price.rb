class Price < ActiveRecord::Base

	belongs_to :strain
	belongs_to :region
  belongs_to :user
  belongs_to :post
	accepts_nested_attributes_for :strain
	accepts_nested_attributes_for :region
	acts_as_list 
	
	scope :sorted, lambda { order("prices.position ASC") }
	scope :newest_first, lambda { order("prices.created_at DESC")}

	def avg_price_per_day	
    	
  end
	    
	
end
