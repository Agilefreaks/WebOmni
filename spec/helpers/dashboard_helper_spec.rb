require 'spec_helper'

describe DashboardHelper, type: :helper do
  describe 'show_calendars_path' do
    context 'user signed in but doesnt have access to calendars api' do
      let(:user) { Fabricate(:user_without_calendar_access) }
      before do
        allow(helper).to receive(:user_signed_in?).and_return(true)
        allow(helper).to receive(:current_user).and_return(user)
      end

      it 'sets new calendar permission on session' do
        expect { helper.show_calendars_path }.to change{ session[:google_permissions]}.to 'calendar.readonly'
      end

      it 'returns the path to authorize the user with the new right' do
        expect(helper.show_calendars_path).to eq '/users/auth/google_oauth2?origin=%2Fcalendars'
      end
    end

    context 'user signed in and has access to calendars api' do
      let(:user) { Fabricate(:user_with_calendar_access) }

      before do
        allow(helper).to receive(:user_signed_in?).and_return(true)
        allow(helper).to receive(:current_user).and_return(user)
      end

      it 'returns the path to show the calendars' do
        expect(helper.show_calendars_path).to eq '/calendars'
      end
    end
  end
end
