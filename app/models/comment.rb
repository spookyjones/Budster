class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
  has_many :replies
  has_attached_file :image, :styles => { :large => "600x600>", :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png" 
  validates_attachment_content_type :image, :content_type => /\Aimage/
    # Validate filename
  validates_attachment_file_name :image, :matches => [/png\Z/, /jpe?g\Z/]
    # Explicitly do not validate
  do_not_validate_attachment_file_type :image
  acts_as_likeable
  acts_as_mentioner
end
