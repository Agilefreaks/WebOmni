require 'spec_helper'

describe User do
  it { is_expected.to have_one(:identity) }

  describe :name do
    subject { User.new(first_name: 'Ion', last_name: 'Din deal').name }

    it { should == 'Ion Din deal' }
  end
end
