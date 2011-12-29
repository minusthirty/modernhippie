class Admin::AdminController < ApplicationController

  layout 'admin'
  
  before_filter :require_admin
  
  private
  def require_admin
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV["ADMIN_USERNAME"] && password == ENV["ADMIN_PASSWORD"]
    end
  end
end
