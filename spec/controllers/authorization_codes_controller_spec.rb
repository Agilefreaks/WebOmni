require 'spec_helper'

describe AuthorizationCodesController do
  describe "POST 'create'" do
    include_context :logged_in_as_user

    subject { xhr :post, :create }

    it 'will call create on AuthorizationCode' do
      expect(CreateAuthorizationCode).to receive(:for).with(current_user.id)
      subject
    end

    context 'when create returns and Authorization Error' do
      it 'will sign user out' do
        response = OpenStruct.new(code: 500, message: 'Internal Server Error')
        allow(CreateAuthorizationCode).to receive(:for).
                                              with(current_user.id).
                                              and_raise(ActiveResource::ServerError.new(response, ''))
        expect(controller).to receive(:sign_out).with(User)
        subject
      end
    end
  end
end
