require 'spec_helper'

describe Users::APIV1 do
  describe "GET 'api/v1/user/activate/:token'" do
    context 'when a user with that token exist' do
      let(:user) { mock_model(User) }

      before { User.stub(find_by: user) }

      it 'should be succesfull' do
        get '/api/v1/users/activate/42'
        response.status.should == 200
      end
    end
  end
end