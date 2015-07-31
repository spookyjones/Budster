module UsersHelper
  
  def largeimage
    "http://graph.facebook.com/#{self.uid}/picture?type=large"
  end
  
  def normalimage
     "http://graph.facebook.com/#{self.uid}/picture?type=normal"
  end
  
end
