require 'spec_helper'

describe ActivationContext do
  let!(:user) { Fabricate(:user) }

  it 'calls activate on user with the token and device name' do
    context = ActivationContext.new(user, '112233', 'windows')
    expect(context.user).to receive(:activate).with('112233', 'windows')
    context.call
  end
end