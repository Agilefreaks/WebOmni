module WebOmni
  class Resources::UsersAPI < Grape::API
    resources :users do
      desc 'Activate a user'
      get 'activate' do
        user = User.find_by(token: headers['Token'])
        present user, :with => Entities::UserActivateResponseEntity
      end
    end
  end
end