require 'spec_helper'

describe User do
  it { should respond_to :first_name }
  it { should respond_to :last_name }

  describe :name do
    subject { User.new(first_name: 'Ion', last_name: 'Din deal').name }

    it { should == 'Ion Din deal' }
  end
end