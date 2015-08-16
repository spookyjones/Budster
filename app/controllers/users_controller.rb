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
    @post = Post.new
    @strain = Strain.new
    @price = Price.new
    @region_options = Region.all.map{|r| [ r.name, r.id ] }
  end

  def update
  end

  def post_create
    @post = Post.new(post_params)
    @region = Region.find(params["post"]["region_id"])
    @user = current_user.id
    @strain = Strain.find_or_create_by(name: params["post"]["strain"]["name"].parameterize)
  #  if !@price_params.blank?
      @price = Price.new(price_params)
      @price.cost = params["post"]["price"]["cost"]
      @price.strain = @strain
      @price.region = @region
      @price.user = current_user
      @price.post = @post
      @price.save
  #  end
  #  if !@price_params.blank? && !@strain_params.blank
  #  end
    @post.user = current_user
    @post.price_id = @price.id
    @post.price = @price
    @post.strain_id = @strain.id
    @post.strain = @strain
    @post.region_id = @region.id
    @post.region = @region
    @post.save
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def post_update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
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
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
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
    def strain_params
      params.require(:post).permit(strain_attributes: [:id, :name])
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:content, :user_id, :price_id, :strain_id, price_attributes: [:id, :cost], strain_attributes: [:id, :name], region_attributes: [:id, :name])
    end
end
