require 'spec_helper'

describe NotificationService do
  let(:service) { NotificationService.new }
  let(:gcm) { double(:gcm) }
  let(:omni_ns) { double(:omni_ns)}
  let(:user) { Fabricate(:user) }
  let(:windows_device_identifier) { 'windows_device_uuid' }
  let(:android_device_identifier) { 'android_device_uuid' }

  before :each do
    service.gcm = gcm
    service.omni_notification_service = omni_ns
    allow(omni_ns).to receive(:send_notification)
    allow(gcm).to receive(:send_notification)
  end

  describe :notify do
    context 'when model is clipping' do
      let(:clipping) { Clipping.new }

      it 'will call clipping and pass model' do
        allow(service).to receive(:clipping)
        expect(service).to receive(:clipping).with(clipping, windows_device_identifier)
        service.notify(clipping, windows_device_identifier)
      end
    end

    context 'when model is PhoneNumber' do
      let(:phone_number) { PhoneNumber.new }

      it 'will call phone_number and pass model' do
        allow(service).to receive(:phone_number)
        expect(service).to receive(:phone_number).with(phone_number, windows_device_identifier)
        service.notify(phone_number, windows_device_identifier)
      end
    end
  end

  shared_examples :omni_notification do |hash|
    context 'when user has no registered devices' do
      it 'will not call send_notification' do
        expect(gcm).to_not receive(:send_notification)
        service.notify(model, windows_device_identifier)
      end
    end

    context 'when user has only one registered device' do
      before :each do
        user.registered_devices.create(registration_id: '42', identifier: android_device_identifier, provider: :gcm)
      end

      it 'will not call send_notification' do
        expect(gcm).to_not receive(:send_notification)
        service.notify(model, android_device_identifier)
      end
    end

    context 'when user has other registered devices' do
      before :each do
        user.registered_devices.create(registration_id: '42', identifier: android_device_identifier, provider: :gcm)
        user.registered_devices.create(registration_id: '43', identifier: windows_device_identifier, provider: :omni)
      end

      context 'and the message is sent from the windows device' do
        it 'will call send_notification with the correct params' do
          expect(gcm).to receive(:send_notification).with(%w(42), hash).once
          service.notify(model, windows_device_identifier)
        end
      end

      context 'and the message is sent from the android device' do
        it 'will call send_notification on the omni notification service' do
          expect(omni_ns).to receive(:send_notification).with(%w(43), hash).once
          service.notify(model, android_device_identifier)
        end
      end
    end
  end

  describe :clipping do
    let(:model) { Clipping.new(user: user) }

    it_behaves_like :omni_notification, {data: {registration_id: 'other'}, collapse_key: 'clipboard'}
  end

  describe :phone_number do
    let(:model) { PhoneNumber.new(user: user, content: '123') }

    it_behaves_like :omni_notification, {data: {registration_id: 'other', phone_number: '123'}, collapse_key: 'call'}
  end
end