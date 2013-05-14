require 'spec_helper'

describe User do
  it { should embed_many(:providers) }

  it 'creates a different token for consecutive users' do
    User.new.token.should_not == User.new.token
  end
end