require 'spec_helper'

describe CalendarsController do
  describe '#index' do
    subject { get :index, :format => "html" }
    context 'user signed in but doesnt have access to calendars api' do
      let(:user) { Fabricate(:user_without_calendar_access, identity: Fabricate(:expired_identity)) }

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
      let(:user) { Fabricate(:user_with_calendar_access, identity: Fabricate(:valid_identity)) }
      let(:calendars_api) { double(Calendars) }

      before do
        allow(controller).to receive(:user_signed_in?).and_return(true)
        allow(controller).to receive(:current_user).and_return(user)
        allow(calendars_api).to receive(:list)
        allow(Calendars).to receive(:new).and_return(calendars_api)
      end

      it 'returns the path to show the calendars' do
        subject
        expect(response).to render_template(:index)
      end

      context 'and there are new calendars' do
        let(:remote_calendars) { [{ 'id' => '42', 'summary' => 'existing calendar' }, { 'id' => '43', 'summary' => 'new calendar' }] }
        let(:existing_calendar) { Fabricate(:calendar, google_id: '42', summary: 'existing calendar') }

        before do
          user.calendars.push existing_calendar
          allow(calendars_api).to receive(:list).and_return(remote_calendars)
        end
        it 'adds the new calendars to the user' do
          expect { subject }.to change { user.calendars.count }.from(1).to(2)

          expect(user.calendars.last.google_id).to eq '43'
        end
      end

      context 'and there are calendars that were removed' do
        let(:remote_calendars) { [{ 'id' => '42', 'summary' => 'existing calendar' }] }
        let(:existing_calendar) { Fabricate(:calendar, google_id: '42', summary: 'existing calendar') }
        let(:existing_calendar_to_be_removed) { Fabricate(:calendar, google_id: '43', summary: 'existing calendar to be removed') }

        before do
          user.calendars.push existing_calendar
          user.calendars.push existing_calendar_to_be_removed
          allow(calendars_api).to receive(:list).and_return(remote_calendars)
        end

        it 'removes the old calendars from the user' do
          expect { subject }.to change { user.calendars.count }.from(2).to(1)

          expect(user.calendars.last.google_id).to eq '42'
        end
      end
    end
  end
end