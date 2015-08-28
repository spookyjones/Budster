class TimelinesController < ApplicationController
  def index
    @reply = Reply.new
    @comment = Comment.new
    @friends_posts = []
    @strains_posts = []
    @pre_sorted_posts = []
    @sorted_posts = []
    current_user.followees(User).each do |friend|
      friend.posts.each do |post|   
        @friends_posts << post
      end
    end
    current_user.followees(Strain).each do |strain|
      strain.posts.each do |post|   
        @strains_posts << post
      end
    end
    
    @pre_sorted_posts = @friends_posts + @strains_posts
    @pre_sorted_posts = @pre_sorted_posts.sort_by { |obj| obj.created_at }
    @sorted_posts = @pre_sorted_posts.reverse
  end

  def show
  end
end
