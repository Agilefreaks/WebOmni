require 'spec_helper'

describe PhoneCalls::FindApiClient do
  describe '.perform' do
    subject { PhoneCalls::FindApiClient.perform({ :api_client_id => '42' }) }

    context 'an api client with the specific id exists' do
      let!(:api_client) { OmniApi::User::Client.new({
                                                     id: 42,
                                                     client_name: 'test',
                                                     client_url: 'http://localhost:3000',
                                                     client_id: 42,
                                                     token: '8mR2+UYID2606IcF3cbifVkV/oYIJZbVDpEUh7pXJ3Z+ekQq6tsYvEzwMXHNvv5rNSpFCqHQRpuw/kj4hXJh/g=='
                                                   }) }

      before { allow(OmniApi::User::Client).to receive(:find).with('42').and_return(api_client) }

      its(:api_client) { is_expected.to be(api_client) }
    end

    context 'an api client with the specific id does not exist' do
      before { allow(OmniApi::User::Client).to receive(:find).and_raise(ActiveResource::ResourceNotFound.new(nil, nil)) }

      its(:success?) { is_expected.to be(false) }

      it 'sets an error message for api client' do
        expect(subject.errors[:api_client].length).to be > 0
      end
    end
  end
end