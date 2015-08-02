class User < ActiveRecord::Base
  has_many :prices
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :omniauthable, :omniauth_providers => [:facebook]

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      auth[:info][:email] ? user.email = auth[:info][:email] : user.email = auth[:uid] + "@facebook.com"
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name   # assuming the user model has a name
      user.image =  auth[:info][:image] # assuming the user model has an image
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
