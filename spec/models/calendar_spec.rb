require 'spec_helper'

describe Calendar do
  it { is_expected.to have_one(:notification_channel) }

  it { is_expected.to belong_to_related(:user) }

  describe '.watched' do
    let(:watched_calendar) { Fabricate(:calendar, { watched: true } ) }
    let(:not_watched_calendar) { Fabricate(:calendar, { watched: false }) }
    let(:watched) { Calendar.watched }

    it 'only includes the calendars that are watched' do
      expect(watched).to include(watched_calendar)
      expect(watched).to_not include(not_watched_calendar)
    end
  end
end