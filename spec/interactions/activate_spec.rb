require 'spec_helper'

describe Activate do
  describe :activate do
    let(:user) { Fabricate(:user) }

    subject { Activate.with(activation_token.content) }

    context 'with un-used activation token' do
      let(:activation_token) { user.activation_tokens.create }

      it { should == user }

      it 'will mark the activation token as used' do
        subject
        user.reload
        expect(user.activation_tokens.last.used).to eq true
      end
    end

    context 'with used activation token' do
      let(:activation_token) { user.activation_tokens.create(used: true) }

      it 'will throw a Document::NotFound' do
        expect { subject }.to raise_exception(Mongoid::Errors::DocumentNotFound)
      end
    end
  end
end