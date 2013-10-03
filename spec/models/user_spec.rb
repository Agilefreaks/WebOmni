require 'spec_helper'

describe User do
  it { should embed_many(:providers) }

  it 'creates a different token for consecutive users' do
    expect(User.new.token).to_not eq User.new.token
  end
end