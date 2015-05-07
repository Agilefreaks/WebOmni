WebOmni::Application.routes.draw do
  get 'sdk/show'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  devise_for :users, skip: [:session, :password, :registration],
                     controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  resources :sdk, only: [:show]

  scope '(:locale)', locale: /en|pt|ro/ do
    devise_for :users, skip: [:omniauth_callbacks]

    resource :authorization_codes, only: [:new]
    resources :contacts, only: [:create]

    resources :downloads, only: [:new] do
      collection do
        get 'generic'
        get 'windows_client'
        get 'android_client'
      end
    end

    namespace :users do
      resources :clients, only: [:new, :create]
    end

    post 'call', as: :call, to: 'pages#call'
    get 'call', to: 'pages#call'

    get 'tos', to: 'pages#tos', as: :tos
  end

  scope 'api' do
    get 'association_failed', to: 'embedable_pages#association_failed'

    scope '/:api_client_id' do
      get 'userAccessToken', to: 'embedable_pages#user_access_token'
    end
  end

  # You can have the root of your site routed with "root"
  get '/:locale', to: 'pages#welcome'
  root to: 'pages#welcome'
end
