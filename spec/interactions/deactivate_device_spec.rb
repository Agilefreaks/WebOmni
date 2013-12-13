require 'spec_helper'

describe DeactivateDevice do
  describe 'with' do
    let(:user) { Fabricate(:user) }

    subject { DeactivateDevice.with('channel' => user.email, 'identifier' => 'violin') }

    context 'with an existing registered device' do
      before :each do
        user.registered_devices.create(identifier: 'violin', registration_id: '42')
      end

      its(:registration_id) { should == nil }
    end

    context 'with no existing device' do
      it 'will raise and exception' do
        expect { subject }.to raise_exception(Mongoid::Errors::DocumentNotFound)
      end
    end
  end
end