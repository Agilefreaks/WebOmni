WebOmni::Application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root to: 'pages#welcome'

  devise_for :users, controllers: {:omniauth_callbacks => 'users/omniauth_callbacks'}

  devise_for :admins
  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  resources :users, only: [:update]
  resources :contact, only: [:create]
  resource :token, only: [:show]

  get 'whatsmytoken', to: 'tokens#show'
  get 'startupchile', to: 'registrations#startupchile'
  get 'soft32', to: 'registrations#soft32'

  get 'pricing', to: 'pages#pricing'

  get 'free_transfer_between_devices', to: 'pages#free'

  #sorry pages
  get 'android_file_transfer', to: 'pages#android_file_transfer'
  get 'android_clipboard_history', to: 'pages#android_clipboard_history'
  get 'smart_actions_between_devices', to: 'pages#smart_actions_between_devices'

  get 'about', to: 'pages#about'
  get 'team', to: 'pages#team'
  get 'contact', to: 'pages#contact'
                                                                                          ``
  # installations
  get 'installations/chrome'
  get 'installations/firefox'
  get 'installations/ie'
  get 'installations/default'

  mount WebOmni::API => '/'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
