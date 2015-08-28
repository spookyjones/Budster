class UsersController < ApplicationController
  
  def index
    @users = User.all
  end
  
  def facebook_friends
    @user_friends = []
    @koala = current_user.info
    @friend_uids = @koala.split(",")
    for f in @friend_uids
      @user_friends << User.find_by(:uid => f)
    end
  end
  
  def show
    @user = User.find(params[:id])
    @sorted_posts = @user.posts.reverse
    @post = Post.new
    @comment = Comment.new
    @reply = Reply.new
    @strain = Strain.new
    @price = Price.new
    @region_options = Region.all.map{|r| [ r.name, r.id ] }
  end

  def update
  end

  def comment_create
    @comment = Comment.new(comment_params)
    @comment.save
    redirect_to :back
  end
  
  def reply_show
    @reply = Reply.new
    @cid = show_reply_params
    @c = Comment.find_by_id(@cid)
    respond_to do |format|
      format.js
    end
  end
  
  def comment_show
    @comment = Comment.new
    @cid = show_comment_params
    @p = Post.find_by_id(@cid)
    respond_to do |format|
      format.js
    end
  end
  
  def reply_create
    @reply = Reply.new(reply_params)
    @reply.save
    redirect_to :back
  end


  def post_create
    @post = Post.new(post_params)
    @region = Region.find(params["post"]["region_id"])
    @user = current_user.id
    unless params["post"]["strain"]["name"].blank? == true
      @strain = Strain.find_or_create_by(name: params["post"]["strain"]["name"].parameterize)
      @post.strain_id = @strain.id
      @post.strain = @strain
    end
    unless params["post"]["price"]["cost"].blank? == true
      @price = Price.new(price_params)
      @price.cost = params["post"]["price"]["cost"]
      @price.strain = @strain
      @price.region = @region
      @price.user = current_user
      @price.post = @post
      @price.save
      @post.price_id = @price.id
      @post.price = @price
    end
  #  if !@price_params.blank? && !@strain_params.blank
  #  end
    @post.user = current_user
    @post.region_id = @region.id
    @post.region = @region
    @post.save
    redirect_to :back
    
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def post_update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to :back, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def post_destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end
    
    def price_params
      params.require(:post).permit(price_attributes: [:id, :cost])
    end
    
    def show_reply_params
      params.require(:comment_id)
    end 
    
    def show_comment_params
      params.require(:post_id)
    end
    
    def strain_params
      params.require(:post).permit(strain_attributes: [:id, :name])
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:content, :image, :user_id, :price_id, :strain_id, price_attributes: [:id, :cost], strain_attributes: [:id, :name], region_attributes: [:id, :name])
    end
    
    def comment_params
      params.require(:comment).permit(:content, :image, :user_id, :post_id)
    end
    
    def reply_params
      params.require(:reply).permit(:content, :image, :user_id, :comment_id)
    end
end
