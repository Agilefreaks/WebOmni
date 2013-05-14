module Users
  class APIV1 < Grape::API

    resource :user do
      desc 'Activates a user'
      params do
        requires :token, type: String, desc: 'Activation token'
      end
      get 'activate/:token' do
        user = User.find_by(token: params[:token])
        present user, :with => Users::UserActivateResponseEntity
      end
    end
  end
end