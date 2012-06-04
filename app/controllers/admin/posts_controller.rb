class Admin::PostsController < Admin::AdminController
  
  before_filter :load_resource, :only => [:edit, :update, :destroy]
  
  def index
    if params[:category_id]
      @category = Category.find(params[:category_id])
      @posts = Post.unscoped.where(:category_id => @category.id).order('created_at desc')
    else
      @posts = Post.unscoped.order('created_at desc')
    end
  end
  
  def edit
  end
  
  def update
    expire_cache(@post.id)
    
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
    expire_cache
    
    @post = Post.create(params[:post])
    if @post.valid?
      redirect_to [:admin, :posts], :notice => "Created new post"
    else
      3.times { @post.images.build } if @post.images.size < 3
      render :action => 'new'
    end
  end
  
  def destroy
    expire_cache(@post.id)
    
    message = "Deleted #{@post.title} post"
    @post.destroy
    redirect_to [:admin, :posts], :notice => message
  end
  
  private
  def expire_cache(post_id=nil)
    expire_action(:controller => :posts, :action => :index)
    expire_action(:controller => :posts, :action => :show, :id => post_id) if post_id
  end
  
  def load_resource
    @post = Post.unscoped.find(params[:id])
  end
end