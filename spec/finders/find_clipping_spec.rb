require 'spec_helper'

describe FindClipping do
  describe :for do
    let(:user) { Fabricate(:user) }

    subject { FindClipping.for(user.email) }

    context 'when user has 1 clipping' do
      let(:clipping) { Clipping.new(content: 'tonight') }

      before(:each) { user.clippings.push(clipping) }

      it { should == clipping }
    end

    context 'when user has more than one clippings' do
      let(:first_clipping) { Clipping.new(created_at: 1.day.ago, content: 'first content') }
      let(:second_clipping) { Clipping.new(created_at: Date.today, content: 'second content') }
      let(:last_clipping) { Clipping.new(created_at: 1.week.ago, content: 'latest content') }

      before(:each) { user.clippings.push([first_clipping, second_clipping, last_clipping]) }

      it { should == second_clipping }
    end

    context 'when user has no clipping' do
      it { should == nil }
    end
  end
end