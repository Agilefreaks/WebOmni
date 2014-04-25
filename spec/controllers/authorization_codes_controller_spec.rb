require 'spec_helper'


describe AuthorizationCodesController do

  describe "POST 'create'" do
    include_context :logged_in_as_user

    subject { xhr :post, :create }

    it 'will call create on AuthorizationCode' do
      expect(AuthorizationCode).to receive(:create).with(user_id: current_user.id)
      subject
    end
  end
end
