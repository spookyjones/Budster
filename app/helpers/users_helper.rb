module UsersHelper
  
  def omniauth_authorize_path(resource_name, provider)
    send "#{resource_name}_omniauth_authorize_path", provider
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
