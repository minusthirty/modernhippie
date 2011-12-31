class PostsController < ApplicationController
  
  # home
  def index
    @posts = Post.all
    @categories = Category.all
  end
  
  
  # post details
  def show
    @post = Post.find(params[:id])
  end
end