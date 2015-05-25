class Price < ActiveRecord::Base
	belongs_to :strain
	validates_presence_of :cost
	belongs_to :region
end
