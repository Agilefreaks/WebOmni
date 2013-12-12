module WebOmni
  class Resources::ActivationAPI < Grape::API
    resource :activation do
      desc 'Get channel based on token.', {
          :headers => {
              :'Token' => {
                  description: 'Secret activation_token. You can get this from the /whatsmytoken page after logging in.',
                  required: true
              }
          }
      }
      put '/' do
        present Activate.with(headers['Token']), :with => Entities::UserActivateResponseEntity
      end
    end
  end
end
