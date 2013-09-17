require 'spec_helper'

describe Clipping do
  it { should validate_presence_of :token }
  it { should validate_presence_of :content }
end