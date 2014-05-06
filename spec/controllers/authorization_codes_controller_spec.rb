require 'spec_helper'


describe AuthorizationCodesController do

  describe "POST 'create'" do
    include_context :logged_in_as_user

    subject { xhr :post, :create }

    it 'will call create on AuthorizationCode' do
      expect(CreateAuthorizationCode).to receive(:for).with(current_user)
      subject
    end
  end
end
