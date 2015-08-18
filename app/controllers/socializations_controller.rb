class SocializationsController < ApplicationController
  before_filter :load_socializable

  def follow
    current_user.follow!(@socializable)
    redirect_to :back
  end

  def unfollow
    current_user.unfollow!(@socializable)
    redirect_to :back
  end
  
  def like
    current_user.like!(@socializable)
    redirect_to :back
  end

  def unlike
    current_user.unlike!(@socializable)
    redirect_to :back
  end
  
private
  def load_socializable
    @socializable =
      case
      when id = params[:comment_id] # Must be before :item_id, since it's nested under it.
        Comment.find_by_id(id)
      when id = params[:post_id]
        Post.find_by_id(id)
      when id = params[:user_id]
        User.find_by_id(id)
      when id = params[:strain_id]
        Strain.find_by_id(id)
      else
        raise ArgumentError, "Unsupported socializable model, params: " +
                             params.keys.inspect
      end
    raise ActiveRecord::RecordNotFound unless @socializable
  end  
end