require 'spec_helper'

describe Calendars::Notifications::VerifyState do
  describe '.perform' do
    context "when state is 'exists'" do
      subject { Calendars::Notifications::VerifyState.perform({ 'X-Goog-Resource-State' => 'exists'}) }

      its(:stopped?) { is_expected.to be false }
    end

    context "When state is 'sync'" do
      subject { Calendars::Notifications::VerifyState.perform({ 'X-Goog-Resource-State' => 'sync'}) }

      its(:stopped?) { is_expected.to be true }
    end
  end
end