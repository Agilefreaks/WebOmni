require 'spec_helper'

describe CreateClipping do
  let(:service) { CreateClipping.new('channel', 'some content') }

  describe :with do
    let(:clipping_factory) { double(ClippingFactory) }
    let(:notification_service) { double(NotificationService) }
    let(:clipping) { Clipping.new }

    before :each do
      service.clipping_factory = clipping_factory
      service.notification_service = notification_service

      allow(clipping_factory).to receive(:create).and_return(clipping)
      allow(notification_service).to receive(:notify)
    end

    it 'will call ClippingFactory#create' do
      expect(clipping_factory).to receive(:create).with('channel', 'some content')
      service.create
    end

    it 'will call NotificationService#notify' do
      expect(notification_service).to receive(:notify).with(clipping)
      service.create
    end

    it 'will return a clipping' do
      expect(service.create).to eq clipping
    end
  end
end