require 'spec_helper'

describe PhoneCalls::FindApiClientAssociation do
  describe '.perform' do
    subject { PhoneCalls::FindApiClientAssociation.perform(api_client_id: '42') }

    context 'an api client with the specific id exists' do
      let!(:api_client) do
        OmniApi::User::ClientAssociation.new(id: 42,
                                             client_name: 'test',
                                             client_url: 'http://localhost:3000',
                                             client_id: 42,
                                             token: '8mR2+UYID2606IcF3cbifVkV/oYIJZbVDpEUh7pXJ3Z+ekQq6tsYvEzwMXHNvv5rNSpFCqHQRpuw/kj4hXJh/g==')
      end

      before { allow(OmniApi::User::ClientAssociation).to receive(:find).with('42').and_return(api_client) }

      its(:client_association) { is_expected.to be(api_client) }
    end

    context 'an api client with the specific id does not exist' do
      before { allow(OmniApi::User::ClientAssociation).to receive(:find).and_raise(ActiveResource::ResourceNotFound.new(nil, nil)) }

      its(:success?) { is_expected.to be(false) }

      it 'sets an error message for api client' do
        expect(subject.errors[:client_association].length).to be > 0
      end
    end
  end
end
