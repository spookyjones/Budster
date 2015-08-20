class Reply < ActiveRecord::Base
  belongs_to :comment
  belongs_to :user
  acts_as_likeable
end
