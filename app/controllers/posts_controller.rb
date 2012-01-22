class PostsController < ApplicationController
  
  # home
  def index
    @posts = Post.all
  end
  
  # post details
  # includes redirect for friendly_id history request
  def show
    @post = Post.find(params[:id], :include => :images)
    @older_post = @post.older_post
    @newer_post = @post.newer_post
      
    if request.path != post_path(@post)
      redirect_to @post, status: :moved_permanently
    end
    
  rescue ActiveRecord::RecordNotFound => e
    Rails.logger.error "Unable to find Post with ID #{params[:id]}: #{e.inspect}"
    redirect_to root_url
  end
end