require 'spec_helper'

describe User do
  it { should embed_many(:providers) }
end