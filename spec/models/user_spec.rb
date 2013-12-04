require 'spec_helper'

describe User do
  it { should embed_many(:providers) }

  it { should embed_many(:activation_tokens) }

  it { should embed_many(:registered_devices) }

  it 'creates a different token for consecutive users' do
    expect(User.new.token).to_not eq User.new.token
  end

  context 'create' do
    before do
      WebOmni::Application::USER_LIMIT = 1
    end

    subject { User.new }

    context 'create if user limit not reached' do
      its(:early_adopter) { should eq true }
    end

    context 'if user limit reached' do
      let!(:active_user) { Fabricate(:user, early_adopter: true) }

      its(:early_adopter) { should eq false }
    end
  end
end