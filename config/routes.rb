Books66::Application.routes.draw do
  
  #offline = Rack::Offline.configure do
  #  cache "/assets/bg.jpg"
  #end
  
  resources :items
  resources :verses
  resources :chapters
  resources :books
  resources :translations
  resources :favourites

  match "/news" => "news#index", :as => :news

  devise_for :users, 
    path_names: {
      sign_in: "signin", 
      sign_out: "signout"
    },
    controllers: {
      omniauth_callbacks: "omniauth_callbacks"
    }

  resources :stories do
    resources :notes
  end
  
  resources :users
  
  authenticated :user do
    resources :notes
    resources :followships
    
    match "/discover/stories" => "discover#index", :as => :discover_stories
    match "/discover/people" => "users#index", :as => :discover_people
    match "/following" => "followships#index", :as => :following
    root :to => 'news#index'
  end
  
  match "/search" => "search#index", :as => :search
  #match "/application.manifest" => offline
  
  match "/:username" => "users#show", :as => :quick_user
  match "/:username/:permalink" => "stories#show", :as => :quick_story
  match "/:version_id/:book_id/:chapter_id" => "chapters#show", :as => :quick_chapter
  match "/:version_id/:book_id/:chapter_id/:verse_id" => "verses#show", :as => :quick_verse
  
  unauthenticated :user do
    root :to => 'discover#index'
  end

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(/assets/(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
