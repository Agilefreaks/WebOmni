require 'spec_helper'

describe Resources::ClippingsAPI do
  describe "POST 'api/v1/clippings'" do
    context 'when there are no validation errors' do
      before { Clipping.stub(:create!, Clipping.new) }

      it 'is successful' do
        post '/api/v1/clippings', {token: 'token', content: 'content'}.to_json, { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
        expect(response.status).to eql 201
      end
    end

    context 'when there are validation errors' do
      it 'returns error' do
        post '/api/v1/clippings', {}.to_json, { 'CONTENT_TYPE' =>'application/json', 'ACCEPT' => 'application/json' }
        expect(response.status).to eql 400
      end
    end
  end

  describe "GET 'api/v1/clippings'" do
    context 'when channel exists and has only one clipping' do
      let(:clipping) { Clipping.new token: 'email@domain.com', content: 'content' }

      before do
        clippings = [clipping]
        Clipping.stub_chain([:find_by]).and_return(clippings)
      end

      it 'returns the clipping' do
        get '/api/v1/clippings', nil, {Channel: 'email@domain.com'}
        expect(response.body).to eql Entities::ClippingEntity.new(clipping).to_json
      end
    end


    context 'When channel exists and has more than one clippings' do
      let(:first_clipping) { Clipping.new created_at: Date.today - 1, token: 'email@domain.com', content: 'first content' }
      let(:last_clipping) { Clipping.new created_at: Date.today, token: 'email@domain.com', content: 'latest content'
      }

      before do
        clippings = [ first_clipping, last_clipping ]
        Clipping.stub_chain(:find_by).and_return(clippings)
      end

      it 'returns the last clipping' do
        get '/api/v1/clippings', nil, {Channel: 'email@domain.com'}
        expect(response.body).to eql Entities::ClippingEntity.new(last_clipping).to_json
      end
    end

    context 'When channel exists and has more than one clippings that are not in order' do
      let(:first_clipping) { Clipping.new created_at: Date.today - 1, token: 'email@domain.com', content: 'first content' }
      let(:last_clipping) { Clipping.new created_at: Date.today, token: 'email@domain.com', content: 'latest content' }

      before do
        clippings = [ last_clipping, first_clipping]
        Clipping.stub_chain(:find_by).and_return(clippings)
      end

      it 'returns the last clipping' do
        get '/api/v1/clippings', nil, {Channel: 'email@domain.com'}
        expect(response.body).to eql Entities::ClippingEntity.new(last_clipping).to_json
      end
    end

    context 'When there is no clipping for that channel' do
      before do
        clippings = []
        Clipping.stub_chain(:find_by).and_return(clippings)
      end

      it 'is successful but with null result' do
        get '/api/v1/clippings/', nil, {Channel: 'email@domain.com'}
        expect(response.body).to eql 'null'
      end
    end
  end
end