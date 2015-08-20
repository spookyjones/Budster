class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
  has_many :replies
  acts_as_likeable
  acts_as_mentioner
end
