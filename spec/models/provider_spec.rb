require 'spec_helper'

describe Provider do
  it { should be_embedded_in(:user) }
end