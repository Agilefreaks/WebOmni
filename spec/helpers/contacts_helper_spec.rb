require 'spec_helper'

describe ContactsHelper do
  describe '.contact' do
    subject { helper.contact(model) }

    context 'with a model instance' do
      let(:model) { Contact.new }

      it { is_expected.to eq model }
    end

    context 'with no model instance' do
      let(:model) { nil }

      it { is_expected.to be_a Contact }
    end
  end
end