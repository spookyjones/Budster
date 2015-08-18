class Review < ActiveRecord::Base
	belongs_to :prices
  acts_as_likeable
end
