Modernhippie::Application.routes.draw do
  

  # private
  namespace :admin do
    resources :posts
  end
  match "/admin", :to => redirect("/admin/posts")
  
  # public
  resources :categories, :only => [:show]
  resources :posts, :only => [:index, :show]
  match '/about' => "posts#about"

  root :to => 'posts#index'
end
