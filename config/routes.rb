Modernhippie::Application.routes.draw do
  
  # public
  resources :posts, :only => [:index, :show]
  
  # private
  namespace :admin do
    resources :posts
  end
  
end
