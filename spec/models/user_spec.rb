require 'spec_helper'

describe User do
  let(:user) { User.new(first_name: 'Ion', last_name: 'Din deal') }

  it { is_expected.to have_one(:identity) }

  describe :name do
    subject { user.name }

    it { should == 'Ion Din deal' }
  end

  describe :access_token_expired? do
    subject { user.access_token_expired? }

    context 'the user has no access_token_expires_at info' do
      before { user.update_attribute(:access_token_expires_at, nil) }

      it { is_expected.to be true }
    end

    context 'the user access_token_expires_at date is older than the current date' do
      before { user.update_attribute(:access_token_expires_at, 3.days.ago) }

      it { is_expected.to be true }
    end

    context 'the user access_token_expires_at date is newer than the current date' do
      before { user.update_attribute(:access_token_expires_at, 3.days.from_now) }

      it { is_expected.to be false }
    end
  end
end
