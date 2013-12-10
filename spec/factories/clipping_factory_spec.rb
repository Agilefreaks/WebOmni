require 'spec_helper'

describe ClippingFactory do
  let(:factory) { ClippingFactory.new }

  describe 'create' do
    let(:user) { Fabricate(:user) }

    subject { factory.create(user.email, content) }

    context 'when content is string' do
      let(:content) { 'some' }

      its(:new_record?) { should == false }

      its(:user) { should == user }

      its(:type) { should == :unknown }

      its(:content) { should == 'some' }
    end

    context 'when content is phone' do
      let(:content) { '+40745857479' }

      its(:type) { should == :phone_number}
    end

    context 'when content is https link' do
      let(:content) { 'https://news.ycombinator.com/item?id=6602902' }

      its(:content) { should == 'https://news.ycombinator.com/item?id=6602902' }
    end
  end
end