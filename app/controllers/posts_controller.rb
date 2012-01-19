class PostsController < ApplicationController
  
  # home
  def index
    @posts = Post.order('created_at desc')
  end
  
  # post details
  def show
    @post = Post.find(params[:id], :include => :images)
    @next_post = @post.next
    @prev_post = @post.prev
  end
  
  def about
    @post = Post.find_by_title('about', :include => :images)
    render 'posts/show'
  end
end