require 'spec_helper'

describe UpdateUserIdentity do
  describe '.perform' do
    let(:user) { Fabricate(:user) }
    let(:expiry_date) { DateTime.now.utc.to_s(:db) }
    let(:token) { 'token' }
    let(:refresh_token) { 'refresh_token' }
    let(:credentials) { {expires: true,  expires_at: expiry_date,  token: token,  refresh_token: refresh_token} }
    let(:scope) { 'some_scope' }
    let(:provider) { 'some_provider' }
    let(:params) { Hashie::Mash.new(credentials: credentials, scope: scope, provider: provider) }

    subject { UpdateUserIdentity.perform(user, params) }

    it 'saves the user identity' do
      subject

      expect(user.identity.changed?).to be false
    end

    describe "the user's identity" do
      subject do
        UpdateUserIdentity.perform(user, params)
        user.reload.identity
      end

      its(:token) { is_expected.to eq token }
      its(:refresh_token) { is_expected.to eq refresh_token }
      its(:expires_at) { is_expected.to eq expiry_date }
      its(:scope) { is_expected.to eq scope }
      its(:provider) { is_expected.to eq provider }
    end
  end
end