require 'spec_helper'

describe UpdateUserAccessToken do
  describe '.perform' do
    let(:user) { Fabricate(:user) }

    subject { UpdateUserAccessToken.perform(user) }

    describe "the given user doesn't have a refresh token" do
      it 'tries to create a new token' do
        token = Hashie::Mash.new(access_token: 'randToken', refresh_token: 'someOtherToken', expires_in: '1234')
        expect(OmniApi::Resources::Oauth2::Token).to receive(:create_for).with(user.email).and_return(token)

        subject
      end

      describe 'can create a token' do
        let(:token) { Hashie::Mash.new(access_token: 'randToken', refresh_token: 'someOtherToken', expires_in: '1234') }
        before { allow(OmniApi::Resources::Oauth2::Token).to receive(:create_for).with(user.email).and_return(token) }

        subject { -> { UpdateUserAccessToken.perform(user) } }

        it { is_expected.to change { user.reload.updated_at } }

        it { is_expected.to change { user.reload.access_token }.to(token.access_token) }

        it { is_expected.to change { user.reload.refresh_token }.to(token.refresh_token) }

        Timecop.freeze do
          let(:current_time) { DateTime.now.utc }
          let(:expected_time) { current_time + 1234.seconds }

          it { is_expected.to change { user.reload.access_token_expires_at.try(:to_s, :db) }.to(expected_time.to_s(:db)) }
        end
      end
    end

    describe 'the given user has a refresh token' do
      before { user.update_attribute(:refresh_token, 'someRefreshToken') }

      it 'tries to refresh the token' do
        token = Hashie::Mash.new(access_token: 'randToken', refresh_token: 'someOtherToken', expires_in: '1234')
        expect(OmniApi::Resources::Oauth2::Token).to receive(:refresh).with(user.refresh_token).and_return(token)

        subject
      end

      describe 'can refresh the token' do
        let(:token) { Hashie::Mash.new(access_token: 'randToken', refresh_token: 'someOtherToken', expires_in: '1234') }
        before { allow(OmniApi::Resources::Oauth2::Token).to receive(:refresh).with(user.refresh_token).and_return(token) }

        subject { -> { UpdateUserAccessToken.perform(user) } }

        it { is_expected.to change { user.reload.updated_at } }

        it { is_expected.to change { user.reload.access_token }.to(token.access_token) }

        it { is_expected.to change { user.reload.refresh_token }.to(token.refresh_token) }

        Timecop.freeze do
          let(:current_time) { DateTime.now.utc }
          let(:expected_time) { current_time + 1234.seconds }

          it { is_expected.to change { user.reload.access_token_expires_at.try(:to_s, :db) }.to(expected_time.to_s(:db)) }
        end
      end
    end
  end
end