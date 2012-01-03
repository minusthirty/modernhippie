class CategoriesController < ApplicationController
  
  def show
    @category = Category.find(params[:id], :include => :posts)
    @posts = @category.posts
    
    if @category.name == 'about'
      @post = @category.posts.first
      render 'posts/show'
    else
      render 'posts/index'
    end
  end
  
end