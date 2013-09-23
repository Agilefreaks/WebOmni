require 'spec_helper'

describe Resources::ClippingsAPI do
  describe "POST 'api/v1/clippings'" do
    let(:options) { {'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json'} }
    let(:params) { {"content" => 'content', "token" => 'token'} }

    it 'will call ClippingFactory.create' do
      expect(ClippingFactory).to receive(:create).with(params)
      post '/api/v1/clippings', params.to_json, options
    end
  end

  describe "GET 'api/v1/clippings'" do
    context 'when channel exists and has only one clipping' do
      let!(:clipping) { Fabricate(:clipping, token: 'email@domain.com', content: 'content') }

      it 'returns the clipping' do
        get '/api/v1/clippings', nil, {Channel: 'email@domain.com'}
        expect(response.body).to eql Entities::ClippingEntity.new(clipping).to_json
      end
    end

    context 'when channel exists and has more than one clippings' do
      let!(:first_clipping) { Fabricate(:clipping, created_at: 1.day.ago, token: 'email@domain.com', content: 'first content') }
      let!(:second_clipping) { Fabricate(:clipping, created_at: Date.today, token: 'email@domain.com', content: 'second content') }
      let!(:last_clipping) { Fabricate(:clipping, created_at: 1.week.ago, token: 'email@domain.com', content: 'latest content') }

      it 'returns the most recent clipping' do
        get '/api/v1/clippings', nil, {Channel: 'email@domain.com'}
        expect(response.body).to eql Entities::ClippingEntity.new(second_clipping).to_json
      end
    end

    context 'When there is no clipping for that channel' do
      it 'is successful but with null result' do
        get '/api/v1/clippings/', nil, {Channel: 'email@domain.com'}
        expect(response.body).to eql 'null'
      end
    end
  end
end