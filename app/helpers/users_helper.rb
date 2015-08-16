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
  
  def friends_list_helper(friend_uids)
    friend_uids.each do |f|
      @friend_uid = User.find_by(:uid => f)
      @friends_list_uids << @friend_uid
    end
  end
end
