class Strain < ActiveRecord::Base
	has_many :prices, :after_add => :update_average_price, :after_remove => :update_average_price 
	has_many :reviews, through: :prices
  has_many :posts, through: :prices
	has_and_belongs_to_many :regions
	accepts_nested_attributes_for :prices 
	accepts_nested_attributes_for :regions
	acts_as_list
	acts_as_likeable
  acts_as_mentionable
  acts_as_followable
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
	
	def update_average_price(strain=nil)	
	    s = strain.prices.sum(:cost)
	    c = strain.prices.count
	    strain.update_attribute(:average_price, c == 0 ? 0.0 : s.to_f / c.to_f)
	end
  
	def self.update_average
	    s = self.prices.sum(:cost)
	    c = self.prices.count
	    self.update_attribute(:average_price, c == 0 ? 0.0 : s.to_f / c.to_f)
	end
end
