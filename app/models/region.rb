class Region < ActiveRecord::Base
	has_many :prices
  has_many :posts
	has_many :strains, :through => :prices
	accepts_nested_attributes_for :strains
	accepts_nested_attributes_for :prices
	def to_s
		name
	end

	def update_average_price(strain=nil)	
	    s = self.prices.sum(:cost)
	    c = self.prices.count
	    self.update_attribute(:average_price, c == 0 ? 0.0 : s.to_f / c.to_f)
	end
end
