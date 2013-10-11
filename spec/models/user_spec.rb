require 'spec_helper'

describe User do
  it { expect(subject).to embed_many(:providers)}

  it { expect(subject).to embed_many(:activation_tokens)}

  it 'creates a different token for consecutive users' do
    expect(User.new.token).to_not eq User.new.token
  end
end