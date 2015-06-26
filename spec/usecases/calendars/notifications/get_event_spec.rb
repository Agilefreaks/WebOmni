require 'spec_helper'

describe Calendars::Notifications::GetEvent do
  let!(:calendar) { Fabricate(:calendar) }
  let!(:events_api) { double(Events) }
  let!(:user) { Fabricate(:user_with_calendar_access) }
  let!(:event) { { event_data: 'bla' } }

  describe '.perform' do
    before do
      allow(Events).to receive(:new).and_return(events_api)
    end

    subject { Calendars::Notifications::GetEvent.perform('X-Goog-Resource-ID' => '42', calendar: calendar, user: user) }

    context 'when event exists' do
      before do
        allow(events_api).to receive(:get).and_return(event)
      end

      its(:event) { is_expected.to eq event }
      its(:success?) { is_expected.to be true }
    end

    context 'when event doesnt exist' do
      before do
        allow(events_api).to receive(:get).and_return(nil)
      end

      its(:success?) { is_expected.to be false }
    end
  end
end
