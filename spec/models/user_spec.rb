require 'spec_helper'

describe User do
  let(:user) { User.new(first_name: 'Ion', last_name: 'Din deal') }

  it { is_expected.to have_one(:identity) }

  describe :name do
    subject { user.name }

    it { should == 'Ion Din deal' }
  end

  describe :access_token_about_to_expire? do
    subject { user.access_token_about_to_expire? }

    context 'the user has no access_token_expires_at info' do
      before { user.update_attribute(:access_token_expires_at, nil) }

      it { is_expected.to be true }
    end

    context 'the user access token will expire in 1 day' do
      before { user.update_attribute(:access_token_expires_at, 1.day.ago) }

      it { is_expected.to be true }
    end

    context 'the user access token will expire in more than 1 day' do
      before { user.update_attribute(:access_token_expires_at, 2.days.from_now) }

      it { is_expected.to be false }
    end
  end
end
