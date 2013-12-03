require 'spec_helper'

describe Device do
  it { should validate_presence_of :registration_id }

  it { should be_embedded_in :user }
end
