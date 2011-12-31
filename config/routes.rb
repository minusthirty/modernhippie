Modernhippie::Application.routes.draw do
  
  # public
  resources :posts, :only => [:index, :show]
  
  # private
  namespace :admin do
    resources :posts
  end
  
  root :to => 'posts#index'
end
