Entrydns::Application.routes.draw do
  
  devise_for :users
  
  resources :domains do
    as_routes
  end

  resources :hosts do
    as_routes
  end

  put '/records/modify/:authentication_token', :to => 'records#modify', :as => :modify_record
  resources :records do
    as_routes
  end

  resources :soas do
    as_routes
  end

  resources :ns do
    as_routes
  end

  resources :mxes do
    as_routes
  end

  resources :as do
    as_routes
  end

  resources :cnames do
    as_routes
  end

  resources :txts do
    as_routes
  end
  
  get '/dashboard', :to => 'dashboard#index', :as => :dashboard
  
  resources :pages, :only => :show
  post 'pages/contact', :to => 'pages#contact'
  
  root :to => 'pages#show', :id => 'home'

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

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
  # match ':controller(/:action(/:id(.:format)))'
end
