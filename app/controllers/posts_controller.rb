class PostsController < ApplicationController
  
  # home
  def index
    @posts = Post.all
  end
  
  # post details
  def show
    @post = Post.find(params[:id], :include => :images)
    @older_post = @post.older_post
    @newer_post = @post.newer_post
  end
  
  def about
    @post = Post.find_by_title('about', :include => :images)
    render 'posts/show'
  end
end