require 'spec_helper'

describe User do
  it { should embed_many(:providers) }

  it { should embed_many(:activation_tokens) }

  it { should embed_many(:registered_devices) }

  context 'create' do
    #noinspection RubyGlobalVariableNamingConvention
    before do
      # use this to remove the 'already initialized constant' warning
      v, $VERBOSE = $VERBOSE, nil
      WebOmni::Application::USER_LIMIT = 1
      $VERBOSE = v
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