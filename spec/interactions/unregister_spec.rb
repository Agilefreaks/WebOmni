require 'spec_helper'

describe Unregister do
  describe :execute do
    let!(:user) { Fabricate(:user, email: 'some@user.com') }

    context 'with a existing device' do
      before :each do
        user.registered_devices.create(identifier: '132')
      end

      it 'will delete the existing device' do
        Unregister.device('channel' => 'some@user.com', 'identifier' => '132')
        user.reload
        expect(user.registered_devices.count).to eq(0)
      end
    end

    context 'with a non existing device' do
      it 'will raise DocumentNotFound' do
        expect { Unregister.device('channel' => 'some@user.com', 'identifier' => '132') }.to raise_exception(Mongoid::Errors::DocumentNotFound)
      end
    end
  end
end