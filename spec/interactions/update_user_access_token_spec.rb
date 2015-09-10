require 'spec_helper'

describe UpdateUserAccessToken do
  describe '.perform' do
    let(:user) { Fabricate(:user) }

    subject { UpdateUserAccessToken.perform(user) }

    it 'tries to create a new token' do
      token = Hashie::Mash.new(token: 'randToken', refresh_token: 'someOtherToken', expires_in: '1234')
      expect(OmniApi::UserAccessTokenFactory).to receive(:create).with(user.email).and_return(token)

      subject
    end

    describe 'can create a token' do
      let(:token) { Hashie::Mash.new(token: 'randToken', refresh_token: 'someOtherToken', expires_in: '1234') }
      before { allow(OmniApi::UserAccessTokenFactory).to receive(:create).with(user.email).and_return(token) }

      subject { -> { UpdateUserAccessToken.perform(user) } }

      it { is_expected.to change { user.reload.updated_at } }

      it { is_expected.to change { user.reload.access_token }.to(token.token) }

      it { is_expected.to change { user.reload.refresh_token }.to(token.refresh_token) }

      Timecop.freeze do
        let(:current_time) { DateTime.now.utc }
        let(:expected_time) { current_time + 1234.seconds }

        it { is_expected.to change { user.reload.access_token_expires_at.try(:to_s, :db) }.to(expected_time.to_s(:db)) }
      end
    end
  end
end