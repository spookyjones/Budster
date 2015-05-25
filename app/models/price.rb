class Price < ActiveRecord::Base
	belongs_to :strain
	validates_presence_of :cost
	
end
