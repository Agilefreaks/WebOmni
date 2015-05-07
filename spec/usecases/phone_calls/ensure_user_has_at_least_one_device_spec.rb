require 'spec_helper'

describe PhoneCalls::EnsureUserHasAtLeastOneDevice do
  describe '.perform' do
    subject { PhoneCalls::EnsureUserHasAtLeastOneDevice.perform }

    context 'at least one device exists for the current user' do
      before { allow(OmniApi::User::Device).to receive(:all).and_return([OmniApi::User::Device.new]) }

      its(:success?) { is_expected.to be(true) }
    end

    context 'no devices exist for the current user' do
      before { allow(OmniApi::User::Device).to receive(:all).and_return([]) }

      its(:success?) { is_expected.to be(false) }

      it 'sets an error message for devices' do
        expect(subject.errors[:devices].length).to be > 0
      end
    end
  end
end