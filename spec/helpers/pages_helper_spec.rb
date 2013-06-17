require 'spec_helper'

describe PagesHelper do
  describe 'winomni_url' do
    subject { helper.winomni_url }

    context 'when Rails.env is staging' do
      before { Rails.stub_chain(env: 'Staging') }

      it { should == 'https://s3.amazonaws.com/omnipaste-staging/win/Omnipaste.application' }
    end

    context 'when Rails.env is production' do
      before { Rails.stub_chain(env: 'Production') }

      it { should == 'https://s3.amazonaws.com/omnipaste-production/win/Omnipaste.application' }
    end
  end
end