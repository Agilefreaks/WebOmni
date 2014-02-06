require 'spec_helper'

describe Call do
  let(:call) { Call.new('some@user.com', '42') }

  describe :with do
    let(:notification_service) { double(:notification_service) }
    let!(:user) { Fabricate(:user, email: 'some@user.com') }

    before :each do
      call.notification_service = notification_service
      allow(notification_service).to receive(:notify)
    end

    it 'will send a call notification with the correct params' do
      expect(notification_service).to receive(:notify).with(an_instance_of(PhoneNumber), '')
      call.execute
    end
  end
end