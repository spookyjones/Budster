Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['204843001866'], ENV['6e86bcbd7fd37c6fe544759c5ad4bed3'],
  :scope => 'email,user_friends'
end