require 'spec_helper'

describe PagesHelper do
  describe 'winomni_url' do
    subject { helper.winomni_url }

    context 'when Rails.env is staging' do
      before { Rails.stub_chain(:env, :staging?).and_return(true) }

      it { should == 'http://cdn.omnipasteapp.com/staging/win/Omnipaste-staging.application' }
    end

    context 'when Rails.env is production' do
      before { Rails.stub_chain(:env, :staging?).and_return(false) }

      it { should == 'http://cdn.omnipasteapp.com/production/win/Omnipaste.application' }
    end
  end

  describe 'android url' do
    subject { helper.android_url }

    context 'when Rails.env is staging' do
      before { Rails.stub_chain(:env, :staging?).and_return(true) }

      it { should == 'http://cdn.omnipasteapp.com/staging/android/omnipaste.apk' }
    end

    context 'when Rails.env is production' do
      before { Rails.stub_chain(:env, :staging?).and_return(false) }

      it { should == 'http://cdn.omnipasteapp.com/production/android/omnipaste.apk' }
    end
  end
end