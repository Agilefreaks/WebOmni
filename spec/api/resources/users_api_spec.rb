require 'spec_helper'

describe Resources::UsersAPI do
  describe "GET 'api/v1/user/activate'" do
    context 'when a user with that token exists' do
      let!(:user) { Fabricate(:user, token: 43) }

      context 'and the token is passed as a header param' do
        it 'is successful' do
          get '/api/v1/users/activate', nil, { 'Token' => '43' }
          expect(response.status).to eql 200
        end
      end
    end
  end
end