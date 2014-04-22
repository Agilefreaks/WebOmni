WebOmni::Application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root to: 'pages#welcome'

  devise_for :users, controllers: {:omniauth_callbacks => 'users/omniauth_callbacks'}

  resources :users, only: [:update]
  resources :contact, only: [:create]
  resource :token, only: [:show]
  resources :pricing, only: [:index, :show]
  resources :downloads, only: [:index] do
    collection do
      get 'windows'
    end
  end

  get 'whatsmytoken', to: 'tokens#show'

  get 'free_transfer_between_devices', to: 'pages#free'

  get :team, to: 'pages#team'
  get :contact, to: 'pages#contact'
  get :tos, to: 'pages#tos'
  get :partners, to: 'pages#partners'

  # partner pages
  [:startupchile, :soft32].each do |partner|
    get partner, to: "registrations##{partner}"
  end

  # sorry pages
  [:android_file_transfer, :android_clipboard_history, :smart_actions_between_devices].each do |action|
    get action, to: 'pricing#show'
  end

  # installations
  get 'installations/chrome'
  get 'installations/firefox'
  get 'installations/ie'
  get 'installations/default'
end
