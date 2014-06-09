WebOmni::Application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root to: 'pages#welcome'

  devise_for :users, controllers: {:omniauth_callbacks => 'users/omniauth_callbacks'}

  resource :authorization_code, only: [:create]
  resources :contacts, only: [:create]

  resources :downloads, only: [:index] do
    collection do
      get 'windows_client'
    end 
  end

  post 'call', as: :call, to: 'pages#call'
end