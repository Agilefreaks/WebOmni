WebOmni::Application.routes.draw do
  get 'sdk/show'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  devise_for :users, skip: [:session, :password, :registration],
                     controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  devise_scope :user do
    get '/users/auth/:provider/setup', to: 'users/omniauth_callbacks#google_oauth2_setup', as: :google_oauth2_setup
  end

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

    post 'call', as: :call, to: 'pages#call'
    get 'call', to: 'pages#call'

    get 'user', to: 'user_profile#show'

    get 'pricing', to: 'pricing#show', as: :show_pricing
    post 'pricing', to: 'pricing#change'

    resources :calendars, only: [:index] do
      member do
        put 'watch'
      end

      collection do
        post 'notifications'
      end
    end

    get 'calendars', to: 'calendars#show'

    get 'tos', to: 'pages#tos', as: :tos
  end

  scope 'api', module: 'js_api' do
    scope '/:api_client_id' do
      get 'prepare_for_phone_usage', to: 'embedable_pages#prepare_for_phone_usage'
      get 'call_in_progress', to: 'embedable_pages#call_in_progress'
      namespace :user do
        resources :clients, only: [:new, :create]
        resources :devices, only: [:new]
      end
    end
  end

  # You can have the root of your site routed with "root"
  get '/:locale', to: 'pages#welcome'
  root to: 'pages#welcome'
end
