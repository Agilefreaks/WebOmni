require "spec_helper"

describe UserFactory do
  let(:factory) { UserFactory.instance }

  describe 'from_social' do
    let(:auth) { mock("auth") }

    context 'with no user' do
      it 'should call create_from_social and update_social' do
        UserFactory.any_instance.should_receive(:create_from_social).with(auth)
        UserFactory.any_instance.should_receive(:create_or_update_provider)
        UserFactory.from_social(auth, nil)
      end
    end

    context 'with user' do
      let(:user) { mock_model(User) }

      it "should update the providers" do
        UserFactory.any_instance.should_receive(:create_or_update_provider).with(auth, user)
        UserFactory.from_social(auth, user)
      end
    end
  end

  describe '#create_from_social' do
    let(:info) { mock('info', :first_name => 'Blind', :last_name => 'Naked', :email => 'sucker@love.com', ) }
    let(:auth) { mock('auth', :info => info) }

    it 'should call create on user' do
      User.should_receive(:create).and_return(mock_model(User))
      NotificationsMailer.stub_chain(:welcome, :deliver)
      factory.create_from_social(auth)
    end
  end

  describe '#create_or_update_provider' do
    let(:user) { mock_model(User) }
    let(:auth) { mock('auth', :provider => 'google', :uid => '42', :info => mock('info', :email => 'bags@email.com')) }

    context 'when find_provider return nil' do
      before { user.stub(:find_provider).and_return(nil) }

      it 'should call social create' do
        providers = mock('providers')
        user.stub(:providers).and_return(providers)
        providers.should_receive(:create)
        factory.create_or_update_provider(auth, user)
      end
    end

    context 'when social find something' do
      let(:user) { mock_model(User) }
      let(:provider) { mock_model(Provider) }

      before { user.stub(:find_provider).and_return(provider) }

      it 'should call update_attributes on social' do
        provider.should_receive(:update_attributes)
        factory.create_or_update_provider(auth, user)
      end
    end
  end
end