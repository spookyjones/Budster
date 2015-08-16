Rails.application.config.middleware.use OmniAuth::Builder do
  if Rails.env.production?
    provider :facebook, ENV['APP_ID'], ENV['APP_SECRET'], :scope => 'email,user_friends,public_profile,user_location'
  else
    provider :facebook, FACEBOOK_CONFIG['app_id'], FACEBOOK_CONFIG['secret'], :scope => 'email,user_friends,public_profile,user_location'
  end
end

