require 'spec_helper'

describe ApplicationHelper do
  describe '.localize' do
    subject { helper.localize('svg/feel', :png) }

    context 'I18n.locale is set to en' do
      before { I18n.locale = :en }

      it { is_expected.to eq 'svg/feel.png' }
    end

    context 'I18n.locale is set to en' do
      before { I18n.locale = :pt }

      it { is_expected.to eq 'svg/feel.pt.png' }
    end
  end
end