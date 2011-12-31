Modernhippie::Application.routes.draw do
  

  # private
  namespace :admin do
    resources :posts
  end
  match "/admin", :to => redirect("/admin/posts")
  
  # public
  resources :posts, :only => [:index, :show]

  root :to => 'posts#index'
end
