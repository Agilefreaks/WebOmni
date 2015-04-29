require 'spec_helper'

describe UserFactory do
  describe 'create_or_update_from_social' do
    let(:email) { 'email@domain.com' }
    let(:first_name) { 'first_name' }

    let(:auth_info) { {email: email, first_name: first_name } }



    let(:auth) { Hashie::Mash.new(info: auth_info) }

    context 'user with the same email exists' do
      let(:existing_user) { Fabricate(:user, email: email)  }
      let(:existing_api_user) { OmniApi::User.new(email: email)}

      before do
        allow(OmniApi::User).to receive_message_chain(:where, :first).and_return(existing_api_user)
        allow(existing_api_user).to receive(:save)
      end

      subject { UserFactory.from_social(auth, existing_user) }

      it 'updates the existing user' do
        expect{subject}.to change { existing_user.first_name }.to(first_name)
      end
    end
  end
end
