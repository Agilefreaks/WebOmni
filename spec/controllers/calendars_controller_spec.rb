require 'spec_helper'

describe CalendarsController do
  describe '#show' do
    subject { get :show }
    context 'user signed in but doesnt have access to calendars api' do
      let(:user) { Fabricate(:user_without_calendar_access) }
      before do
        allow(controller).to receive(:user_signed_in?).and_return(true)
        allow(controller).to receive(:current_user).and_return(user)
      end

      it 'sets new calendar permission on session' do
        expect { subject }.to change{ session[:google_permissions]}.to 'calendar.readonly'
      end

      it 'returns the path to authorize the user with the new right' do
        expect(subject).to redirect_to user_omniauth_authorize_path(provider: :google_oauth2, origin: '/en/calendars')
      end
    end

    context 'user signed in and has access to calendars api' do
      let(:user) { Fabricate(:user_with_calendar_access) }

      before do
        allow(controller).to receive(:user_signed_in?).and_return(true)
        allow(controller).to receive(:current_user).and_return(user)
      end

      it 'returns the path to show the calendars' do
        expect(subject).to render_template(:show)
      end
    end
  end
end