module WebOmni
  class Resources::UsersAPI < Grape::API
    resources :users do
      desc 'Activate a user'
      params do
        requires :token, type: String, desc: 'Activation token'
      end
      get 'activate/:token' do
        user = User.find_by(token: params[:token])
        present user, :with => Entities::UserActivateResponseEntity
      end
    end
  end
end