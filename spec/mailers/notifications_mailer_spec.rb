require 'spec_helper'

describe NotificationsMailer do
  describe '#welcome' do
    let(:user) { mock_model(User, email: 'ciprian@test.com', name: 'Ion') }

    before { User.stub(find: user) }

    subject { NotificationsMailer.welcome('42') }

    it { should deliver_to('ciprian@test.com') }

    it { should deliver_from('Calin <calin@omnipasteapp.com>') }

    it { should have_subject('Welcome to Omnipaste') }
  end
end