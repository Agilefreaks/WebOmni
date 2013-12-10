require 'spec_helper'

describe NotificationService do
  let(:service) { NotificationService.new }

  describe :notify do
    let(:gcm) { double(:gcm) }
    let(:user) { Fabricate(:user) }
    let(:clipping) { Clipping.new(user: user) }

    before :each do
      service.gcm = gcm
      allow(gcm).to receive(:send_notification)
    end

    context 'when user has no registered devices' do
      it 'will not call send_notification' do
        expect(gcm).to_not receive(:send_notification)
        service.notify(clipping)
      end
    end

    context 'when user has registered devices' do
      before :each do
        user.registered_devices.create(registration_id: '42')
        user.registered_devices.create(registration_id: '43')
      end

      it 'will call send_notification with the correct params' do
        expect(gcm).to receive(:send_notification).with(%w(42 43), {data: {registration_id: 'other'}, collapse_key: 'clipboard'}).once
        service.notify(clipping)
      end
    end
  end
end