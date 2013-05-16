require 'spec_helper'

describe PagesHelper do
  describe 'winomni_url' do
    subject { helper.winomni_url }

    context 'when Rails.env.staging? is true' do
      before { Rails.stub_chain(:env, :staging?).and_return(true) }

      it { should == 'https://s3.amazonaws.com/omnipaste/win_staging/Omnipaste.application' }
    end

    context 'when Rails.env.staging? is false' do
      before { Rails.stub_chain(:env, :staging?).and_return(false) }

      it { should == 'https://s3.amazonaws.com/omnipaste/win/Omnipaste.application' }
    end
  end
end