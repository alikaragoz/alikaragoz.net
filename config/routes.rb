Alikaragoz::Application.routes.draw do
  
  root to: 'posts#index'

  # Static pages
  match '/about' => 'pages#about'

  # Atom feed
  match '/feed' => 'posts#feed', :as => :feed, :defaults => { :format => 'atom' }
  
  # Login
  match '/login' => 'login#login'
  match '/logout' => 'login#logout'

  resources :posts do
    # Kaminari friendly URL
    # => from : http://localhost:3000/posts?page=2
    # => to : http://localhost:3000/posts/page/2
    get 'page/:page', :action => :index, :on => :collection
  end
  
  resources :tags do
    # Kaminari friendly URL
    # => from : http://localhost:3000/tags/canon?page=2
    # => to : http://localhost:3000/tags/canon/page/2
    get ':id/page/:page', :action => :show, :on => :collection
  end

  # The routes below are for the transition to the new URL

  # match any tags from a url like this :
  # => http://localhost:3000/category/black-white
  # and redirects it with a HTTP 301 to :
  # => http://localhost:3000/tag/black-white
  match '/category/*slug' => redirect("/tags/%{slug}")

  # match any post from a url like this :
  # => http://localhost:3000/hello-world
  # and redirects it with a HTTP 301 to :
  # => http://localhost:3000/posts/hello-world
  match '/*slug' => redirect("/posts/%{slug}")

end
