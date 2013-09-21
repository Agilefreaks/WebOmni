require 'spec_helper'

describe Resources::ClippingsAPI do
  describe "POST 'api/v1/clippings'" do
    let(:options) { {'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json'} }

    context 'when there are no validation errors' do
      subject { post '/api/v1/clippings', {token: 'token', content: 'content'}.to_json, options }

      it { should == 201 }

      it 'adds a clipping' do
        expect { subject }.to change { Clipping.count }.by 1
      end

      it 'creates a clipping with the correct fields' do
        subject
        clipping = Clipping.last
        expect(clipping.token).to eq('token')
        expect(clipping.content).to eq('content')
        expect(clipping.type).to eq(:phone_number)
      end
    end

    context 'when there are validation errors' do
      subject { post '/api/v1/clippings', {}.to_json, options }

      it { should == 400 }

      it 'does not add a clipping' do
        expect { subject }.not_to change { Clipping.count }
      end
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