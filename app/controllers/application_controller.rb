class ApplicationController < ActionController::Base

  before_filter :load_categories

  protect_from_forgery
  
  private
  def load_categories
    @categories ||= Category.all
  end
end
