require 'spec_helper'

describe MenuCell, type: :cell do
  context 'cell instance' do
    subject { cell(:menu, user) }

    context 'with a user' do
      let(:user) { User.new }

      it { is_expected.to be_a(AuthorizedMenuCell) }
    end

    context 'with no user' do
      let(:user) { nil }

      it { is_expected.to be_a(UnauthorizedMenuCell) }
    end
  end
end
