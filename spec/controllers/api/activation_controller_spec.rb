require 'spec_helper'

describe Api::ActivationController do
  it { should respond_to(:activate) }

  describe '#activate' do
    context 'token exists' do
      before { User.stub_chain(:find_by).and_return(mock_model(User, email: 'test')) }

      it 'returns a valid activation data object' do
        get :activate, token: 'someToken', :format => :json
        response.body.should == '{"activation_data":{"channel":"test"}}'
      end
    end

    context 'token does not exist' do
      before { User.stub_chain(:find_by).and_throw(Mongoid::Errors::DocumentNotFound) }

      it 'raises DocumentNotFound exception' do
        lambda {
          get :activate, token: 'someToken', :format => :json
        }.should raise_error
      end
    end
  end
end