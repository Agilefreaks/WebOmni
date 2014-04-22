require 'spec_helper'

describe UserFactory do
  let(:factory) { UserFactory.instance }

  describe :create_from_social do
    let(:info) { double('info', first_name: 'Blind', last_name: 'Naked', email: 'sucker@love.com',) }
    let(:auth) { double('auth', info: info, provider: 'provider', uid: 'uid', auth: 'auth') }

    subject { factory.create_from_social(auth) }

    it 'will save user and send notification' do
      expect_any_instance_of(User).to receive(:save)
      NotificationsMailer.stub_chain(:welcome, :deliver)

      subject
    end
  end
end