class ApplicationController < ActionController::Base

  before_filter :find_categories

  protect_from_forgery
  
  private
  def find_categories
    @categories ||= Category.all
  end
end
