WebOmni::Application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root to: 'pages#welcome'

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  resource :authorization_codes, only: [:create, :new]
  resources :contacts, only: [:create]

  resources :downloads, only: [:new] do
    collection do
      get 'windows_client'
      get 'android_client'
    end
  end

  post 'call', as: :call, to: 'pages#call'

  get 'tos', to: 'pages#tos', as: :tos
end