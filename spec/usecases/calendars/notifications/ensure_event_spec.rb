require 'spec_helper'

describe Calendars::Notifications::EnsureEvent do
  describe '.perform' do
    context 'uri ends in /events' do
      subject { Calendars::Notifications::EnsureEvent.perform('X-Goog-Resource-URI' => 'blabla /events') }

      its(:stopped?) { is_expected.to be false }
    end

    context 'uri ends in /events' do
      subject { Calendars::Notifications::EnsureEvent.perform('X-Goog-Resource-URI' => 'blabla /calendars') }

      its(:stopped?) { is_expected.to be true }
    end
  end
end
