class Price < ActiveRecord::Base
	validates_presence_of :cost
end
