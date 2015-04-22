require 'spec_helper'

describe UserFactory do
  describe 'create_or_update_from_social' do
    let(:email) { 'email@domain.com' }
    let(:first_name) { 'first_name' }
    let(:last_name) { 'last_name' }
    let(:image) { 'image' }
    let(:auth_info) { {email: email, first_name: first_name, last_name: last_name, image: image } }
    let(:credentials) { Hashie::Mash.new({
                                           expires: true,
                                           expires_at: DateTime.now + 1.month,
                                           token: 'token',
                                           refresh_token: 'refresh_token'
                                         })}
    let(:auth) { Hashie::Mash.new(info: auth_info) }
    let(:user) { Fabricate(:user, email: email)  }

    subject { UserFactory.from_social(auth, user) }

    before do
      auth.info = auth_info
      auth.credentials = credentials
    end

    context 'user with the same email exists' do
      let(:existing_api_user) { OmniApi::User.new }

      before do
        allow(OmniApi::User).to receive_message_chain(:where, :first).and_return(existing_api_user)
        allow(existing_api_user).to receive(:save)
      end

      it "updates the existing user's first_name" do
        expect{ subject }.to change { user.first_name }.to(first_name)
      end

      it "updates the existing user's last_name" do
        expect{ subject }.to change { user.last_name }.to(last_name)
      end

      it "updates the existing user's image" do
        expect{ subject }.to change { user.image_url }.to(image)
      end

      it 'saves the user' do
        expect(user).to receive(:save)
        subject
      end
    end

    context 'new user' do
      let(:new_api_user) { OmniApi::User.new(email: email, first_name: first_name, last_name: last_name, image_url: image) }

      before do
        allow(OmniApi::User).to receive_message_chain(:where, :first).and_return(nil)
        allow(new_api_user).to receive(:save)
        allow(OmniApi::User)
          .to receive(:new)
          .with(
            first_name: auth.info.first_name,
            last_name: auth.info.last_name,
            email: auth.info.email.downcase,
            image_url: auth.info.image)
          .and_return(new_api_user)
      end

      it 'saves the user' do
        expect(user).to receive(:save)
        subject
      end
    end
  end
end
