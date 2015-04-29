require 'spec_helper'

describe User do
  describe :name do
    subject { User.new(first_name: 'Ion', last_name: 'Din deal').name }

    it { should == 'Ion Din deal' }
  end
end