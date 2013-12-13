require 'spec_helper'

describe RegisteredDevice do
  it { should validate_presence_of :identifier }

  it { should be_embedded_in :user }
end
