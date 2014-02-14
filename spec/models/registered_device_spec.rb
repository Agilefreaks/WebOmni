require 'spec_helper'

describe RegisteredDevice do
  it { should validate_presence_of :identifier }

  it {should ensure_inclusion_of(:provider).in_array [:gcm, :omni] }

  it { should be_embedded_in :user }

  describe 'active' do
    let(:user) { Fabricate(:user) }
    let!(:active_device) { user.registered_devices.create(identifier: '1', registration_id: '1') }
    let!(:inactive_device) { user.registered_devices.create(identifier: '2') }

    it 'will return only active devices' do
      expect(user.registered_devices.active.entries).to eq [active_device]
    end
  end
end
