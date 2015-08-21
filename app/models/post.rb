class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :region
  has_one :price
  has_one :strain
  has_many :comments
  has_attached_file :image, :styles => { :large => "600x600>", :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png" 
  validates_attachment_content_type :image, :content_type => /\Aimage/
    # Validate filename
  validates_attachment_file_name :image, :matches => [/png\Z/, /jpe?g\Z/]
    # Explicitly do not validate
  do_not_validate_attachment_file_type :image
  accepts_nested_attributes_for :price, :strain
  validates_presence_of :content, :unless => :image?
  acts_as_likeable
end
