WebOmni::Application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  devise_for :users, skip: [:session, :password, :registration], controllers: {omniauth_callbacks: 'users/omniauth_callbacks'}

  scope '(:locale)', locale: /en|pt|ro/ do
    devise_for :users, skip: [:omniauth_callbacks]

    resource :authorization_codes, only: [:new]
    resources :contacts, only: [:create]

    resources :downloads, only: [:new] do
      collection do
        get 'windows_client'
        get 'android_client'
      end
    end

    post 'call', as: :call, to: 'pages#call'
    get 'call', to: 'pages#call'

    get 'tos', to: 'pages#tos', as: :tos
  end

  # You can have the root of your site routed with "root"
  get '/:locale', to: 'pages#welcome'
  root to: 'pages#welcome'
end