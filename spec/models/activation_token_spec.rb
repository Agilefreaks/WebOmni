require 'spec_helper'

describe ActivationToken do
  it { should be_embedded_in(:user) }

  it { should respond_to(:content) }

  its(:type) { should eq :unknown }

  its(:used) { should eq false }
end