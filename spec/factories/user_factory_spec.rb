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
    let(:auth) { Hashie::Mash.new(info: auth_info) }

    subject { UserFactory.from_social(auth, user) }

    before do
      auth.info = auth_info
      auth.credentials = credentials
    end

    context 'with an existing user' do
      let(:user) { Fabricate(:user, email: email)  }

      it "updates the existing user's first_name" do
        expect { subject }.to change { user.first_name }.to(first_name)
      end

      it "updates the existing user's last_name" do
        expect { subject }.to change { user.last_name }.to(last_name)
      end

      it "updates the existing user's image" do
        expect { subject }.to change { user.image_url }.to(image)
      end

      it 'saves the user' do
        expect(user).to receive(:save)
        subject
      end

      it 'saves the user identity' do
        subject

        expect(user.identity).to_not be nil
      end

      it 'sets correct token on identity' do
        subject

        expect(user.identity.token).to eq 'token'
      end
    end

    context 'new user' do
      let(:user) { nil }

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
