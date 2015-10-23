Entrydns::Application.routes.draw do

  mount RailsAdmin::Engine => '/rails_admin', as: 'rails_admin'

  devise_for :admins

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  scope module: 'users' do

    resources :authentications do
      as_routes
    end

    resources :domains do
      as_routes
    end

    resources :hosts do
      as_routes
      member do
        put 'new_token'
      end
    end

    match '/records/modify/:authentication_token', to: 'records#modify',
      as: :modify_record, via: [:get, :post, :put]
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
      member do
        put 'new_token'
      end
    end

    resources :cnames do
      as_routes
    end

    resources :txts do
      as_routes
    end

    resources :aaaas do
      as_routes
    end

    resources :srvs do
      as_routes
    end

    resources :permissions do
      as_routes
    end

  end

  scope module: 'public' do

    resources :pages, only: :show, path: ''
    post 'contact', to: 'pages#contact'

    root to: 'pages#show', id: 'home'

  end

end
