require 'spec_helper'

describe ActivationContext do
  let!(:user) { Fabricate(:user) }

  describe :activate do
    it 'calls activate on user with the token and device name' do
      context = ActivationContext.new(user, '112233', 'windows')
      expect(context.user).to receive(:activate).with('112233', 'windows')
      context.activate
    end
  end


  describe :get_activation_token do
    it 'calls get_activation_token on the user' do
      context = ActivationContext.new(user)
      expect(user).to receive(:get_activation_token)

      context.get_activation_token
    end
  end
end