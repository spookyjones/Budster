class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :region
  has_one :price
  has_one :strain
  accepts_nested_attributes_for :price, :strain
  validates_presence_of :content

end
