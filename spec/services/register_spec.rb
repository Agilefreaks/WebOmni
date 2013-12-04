require 'spec_helper'

describe Register do
  describe 'execute' do
    let!(:user) { Fabricate(:user, email: 'user@email.com') }

    context 'when user has a device with the same registration id' do
      before :each do
        user.registered_devices.create(registration_id: '123')
      end

      it 'will update the existing device' do
        Register.device('user@email.com', '123')
        user.reload
        expect(user.registered_devices.count).to eq(1)
      end
    end

    context 'when the user has no device' do
      it 'will create a new device' do
        Register.device('user@email.com', '123')
        user.reload
        expect(user.registered_devices.count).to eq 1
      end
    end
  end
end