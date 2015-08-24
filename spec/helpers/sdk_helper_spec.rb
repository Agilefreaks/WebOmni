require 'spec_helper'

RSpec.describe SdkHelper, type: :helper do
  describe 'i18n_translations' do
    let(:locale) { :en }

    subject { helper.i18n_translations(locale) }

    context 'translations for the given locale exist' do
      let(:locale) { :ro }

      it { is_expected.to be_present }
    end

    context 'translations for the given locale do not exist' do
      let(:locale) { :xx }

      it { is_expected.to be_nil }
    end
  end

  describe 'i18n_translations_or_default' do
    let(:locale) { :en }

    subject { helper.i18n_translations_or_default(locale) }

    context 'translations for the given locale exist' do
      let(:locale) { :ro }

      it { is_expected.to be_present }
    end

    context 'translations for the given locale do not exist' do
      let(:locale) { :xx }

      it { is_expected.to eq(helper.i18n_translations(:en)) }
    end
  end
end
