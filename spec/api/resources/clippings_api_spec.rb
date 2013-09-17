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
      let(:clipping) { Clipping.new token: 'email@domain.com', content: 'content' }

      before do
        clippings = [clipping]
        Clipping.stub_chain([:where, :desc]).and_return(clippings)
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
        clippings = [last_clipping, first_clipping]
        Clipping.stub_chain([:where, :desc]).and_return(clippings)
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
        clippings = [last_clipping, first_clipping]
        Clipping.stub_chain([:where, :desc]).and_return(clippings)
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