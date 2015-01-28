require 'spec_helper'

describe Track do
  let(:service) { Track::Service.new }

  describe :user_created do
    let(:params) { { '$some_property' => 'some value' } }

    subject { service.user_created(email, params) }

    context 'with a email not belonging to a user' do
      let(:email) { 'some@email.com' }

      it 'will not call alias or people' do
        subject
        expect(OmniKiq::Trackers::MixpanelAlias).not_to receive(:perform_async)
        expect(OmniKiq::Trackers::MixpanelPeople).not_to receive(:perform_async)
      end
    end

    context 'with a email from an existing user' do
      let(:email) { 'existing@email.com' }

      before do
        Fabricate(:user, email: email, aliased: aliased, mixpanel_distinct_id: '42')
      end

      context 'when the user has alias set' do
        let(:aliased) { true }

        it "will call set and don't call alias" do
          expect(OmniKiq::Trackers::MixpanelPeople).to receive(:perform_async)
          expect(OmniKiq::Trackers::MixpanelAlias).not_to receive(:perform_async)
          subject
        end
      end

      context 'when the user has no alias set' do
        let(:aliased) { false }

        it 'will call alias and people set' do
          expect(OmniKiq::Trackers::MixpanelPeople).to receive(:perform_async)
          expect(OmniKiq::Trackers::MixpanelAlias).to receive(:perform_async)
          subject
        end
      end
    end
  end
end