class Admin::PostsController < Admin::AdminController
  
  before_filter :load_resource, :only => [:edit, :update, :destroy]
  
  def index
    @posts = Post.unscoped.order(:published_at)
  end
  
  def edit
    3.times { @post.images.build } if @post.images.size < 3
  end
  
  def update
    if @post.update_attributes(params[:post])
      redirect_to [:admin, :posts], :notice => "Updated post"
    else
      3.times { @post.images.build } if @post.images.size < 3  
      render :action => 'edit'
    end
  end
  
  def new
    @post = Post.new
    3.times { @post.images.build }
  end
  
  def create
    @post = Post.create(params[:post])

    if @post.valid?
      redirect_to [:admin, :posts], :notice => "Created new post"
    else
      3.times { @post.images.build } if @post.images.size < 3
      render :action => 'new'
    end
  end
  
  def destroy
    message = "Deleted #{@post.title} post"
    @post.destroy
    redirect_to [:admin, :posts], :notice => message
  end
  
  private
  def load_resource
    @post = Post.unscoped.find(params[:id])
  end
end