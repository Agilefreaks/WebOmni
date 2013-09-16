require 'spec_helper'

describe Resources::UsersAPI do
  describe "GET 'api/v1/user/activate/:token'" do
    context 'when a user with that token exists' do
      let(:user) { mock_model(User) }

      before { User.stub(find_by: user) }

      it 'is successful' do
        get '/api/v1/users/activate/43'
        expect(response.status).to eql 200
      end
    end
  end
end