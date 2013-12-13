require 'spec_helper'

describe ActivateDevice do
  describe 'with' do
    let(:user) { Fabricate(:user) }

    subject { ActivateDevice.with('channel' => user.email, 'identifier' => 'flute', 'registration_id' => '42') }

    context 'with an existing registered device' do
      before :each do
        user.registered_devices.create(identifier: 'flute')
      end

      its(:registration_id) { should == '42' }
    end

    context 'with no existing device' do
      it 'will raise and exception' do
        expect { subject }.to raise_exception(Mongoid::Errors::DocumentNotFound)
      end
    end
  end
end