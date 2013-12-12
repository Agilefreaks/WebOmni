require 'spec_helper'

describe Resources::ActivationAPI do
  describe "PUT '/api/v1/activation'" do
    let(:options) { {:'CONTENT_TYPE' => 'application/json', :'ACCEPT' => 'application/json', :'Token' => '42'} }

    it 'will call Activate#with' do
      expect(Activate).to receive(:with).with('42')
      put '/api/v1/activation', '', options
    end
  end
end