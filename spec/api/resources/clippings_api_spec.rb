require 'spec_helper'

describe Resources::ClippingsAPI do
  let(:options) { {:'CONTENT_TYPE' => 'application/json', :'ACCEPT' => 'application/json', :'Channel' => email} }

  describe "POST 'api/v1/clippings'" do
    let(:params) { {:'content' => 'content'} }

    context 'with a valid channel' do
      include_context :logged_in_as_user

      let(:email) { current_user.email }

      it 'will call create with the correct params on the factory' do
        allow(CreateClipping).to receive(:with).and_return(Clipping.new)
        expect(CreateClipping).to receive(:with).with('content' => 'content', 'channel' => email)

        post '/api/v1/clippings', params.to_json, options
      end
    end

    context 'with a invalid channel' do
      let(:email) { 'some@other.com' }

      it 'will raise error' do
        post '/api/v1/clippings', params.to_json, options
        expect(response.code).to eq('401')
      end
    end
  end

  describe "GET 'api/v1/clippings/last'" do
    context 'with a valid channel' do
      include_context :logged_in_as_user

      context 'and only 1 clipping' do
        let(:email) { current_user.email }
        let(:clipping) { Clipping.new(content: 'content') }

        it 'calls FindClipping for with correct argument' do
          allow(FindClipping).to receive(:for).with(email).and_return(clipping)
          get '/api/v1/clippings/last', nil, options
          expect(response.body).to eql Entities::ClippingEntity.new(clipping).to_json
        end
      end
    end
  end
end