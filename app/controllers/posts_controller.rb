class PostsController < ApplicationController
  
  # home
  def index
    @posts = Post.all
    @categories = Category.all
  end
  
  
  # post details
  def show
    @post = Post.find(params[:id], :include => :images)
    @next_post = @post.next
    @prev_post = @post.prev
  end
end