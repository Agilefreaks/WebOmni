require 'spec_helper'

describe Calendars::Notifications::FindUser do
  describe '.perform' do
    subject { Calendars::Notifications::FindUser.perform({ 'X-Goog-Channel-ID' => '42' }) }

    context 'there is a user with that notification channel' do
      let(:user) { Fabricate(:user_with_calendar_access) }
      let!(:calendar) { Fabricate(:calendar, user: user) }
      let!(:notification_channel) { Fabricate(:notification_channel, uuid: 42, calendar: calendar) }
      it 'sets the user on the context' do
        expect(subject.user).to eq user
      end

      it 'sets the calendar on the context' do
        expect(subject.calendar).to eq calendar
      end
    end

    context 'there isnt a user with that notification channel' do
      it 'fails' do
        expect(subject.success?).to be false

        expect(subject.errors[:notification_channel].first).to eq 'No channel found with uuid = 42'
      end
    end
  end
end