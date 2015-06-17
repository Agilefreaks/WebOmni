require 'spec_helper'

RSpec.describe :CalendarList do

  describe '#list' do
    let(:user) { User.new(identity: Identity.new) }

    subject { CalendarList.new.list(user) }

    it { is_expected.to be_a(Array)}
  end
end