Rails.application.config.middleware.use OmniAuth::Builder do
  if Rails.env.production?
    provider :facebook, ENV['APP_ID'], ENV['APP_SECRET'],
    :scope => 'email,user_friends'
  else
    provider :facebook, FACEBOOK_CONFIG['app_id'], FACEBOOK_CONFIG['secret'],
    :scope => 'email,user_friends'
  end
end

