require 'spec_helper'

describe OmniApi::Oauth2::Token do
  describe '.collection_name' do
    subject { OmniApi::Oauth2::Token.collection_name }

    it { is_expected.to eq('token') }
  end
end