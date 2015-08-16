class User < ActiveRecord::Base
  has_many :prices
  has_many :posts
  has_many :friendships
  has_many :friends, :through => :friendships
  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
  has_many :inverse_friends, :through => :inverse_friendships, :source => :user
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :omniauthable, :omniauth_providers => [:facebook]

  attr_accessor :koala_friends_list

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      auth[:info][:email] ? user.email = auth[:info][:email] : user.email = auth[:uid] + "@facebook.com"
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name   # assuming the user model has a name
      user.image = auth[:info][:image] # assuming the user model has an image
      #user.home_location = auth[:info][:location]
      #facebook = Koala::Facebook::API.new(access_token)
      #user.friends = facebook.get_connections("me", "friends")
      user.last_sign_in_at = Time.now
      user.info = auth.inspect
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def self.koala(auth)
    access_token = auth['token']
    facebook = Koala::Facebook::API.new(access_token)
    facebook.get_object("me?fields=email,friends")
  end
  
  def self.koala_friends(auth)
    access_token = auth['token']
    @graph = Koala::Facebook::API.new(access_token)
    friends = @graph.get_connections("me", "friends")
  end

  def largeimage
    "http://graph.facebook.com/#{self.uid}/picture?type=large"
  end

  def normalimage
     "http://graph.facebook.com/#{self.uid}/picture?type=normal"
  end

  def smallimage
     "http://graph.facebook.com/#{self.uid}/picture?type=small"
  end

end
