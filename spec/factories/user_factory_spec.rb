require 'spec_helper'

describe UserFactory do
  describe 'create_or_update_from_social' do
    let(:email) { 'email@domain.com' }
    let(:first_name) { 'first_name' }
    let(:last_name) { 'last_name' }
    let(:image) { 'image' }
    let(:auth_info) { { email: email, first_name: first_name, last_name: last_name, image: image } }
    let(:credentials) do
      Hashie::Mash.new(expires: true,
                       expires_at: Time.zone.now + 1.month,
                       token: 'token',
                       refresh_token: 'refresh_token')
    end
    let(:auth) { Hashie::Mash.new(info: auth_info, credentials: credentials, provider: 'provider', scope: 'test') }

    subject { UserFactory.create_or_update(auth) }

    describe 'a user with the given email exists' do
      let(:user) { Fabricate(:user) }

      before { auth_info[:email] = user.email }

      it "updates the existing user's first_name" do
        expect { subject }.to change { user.reload.first_name }.to(first_name)
      end

      it "updates the existing user's last_name" do
        expect { subject }.to change { user.reload.last_name }.to(last_name)
      end

      it "updates the existing user's image" do
        expect { subject }.to change { user.reload.image_url }.to(image)
      end
    end

    context 'a user with the given email does not exist' do
      it 'saves the user' do
        expect { subject }.to change(User, :count).by(1)
      end

      it 'saves the user identity' do
        subject

        expect(User.last.identity.token).to eq 'token'
      end
    end
  end
end
