require 'spec_helper'

describe SdkController do
  describe 'GET #show' do
    let(:id) { '5385e2db6465762d96000000' }

    subject { get :show, id: id, format: :js }

    it 'tries to find a client with the given id' do
      expect(OmniApi::Resources::Client).to receive(:find).with(id).and_return(OmniApi::Resources::Client.new)

      subject
    end

    context 'can find client with given id' do
      before { allow(OmniApi::Resources::Client).to receive(:find).with(id).and_return(OmniApi::Resources::Client.new) }

      its(:status) { is_expected.to eq(200) }
    end
  end
end
