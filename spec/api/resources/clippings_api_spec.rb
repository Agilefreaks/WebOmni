require 'spec_helper'

describe Resources::ClippingsAPI do
  describe "GET 'api/v1/clippings/:id'" do
    context 'when the clipping doesnt exist for current user' do
      it 'should return not found' do
        get '/api/v1/clippings/43'
        response.status.should == 404
      end
    end

    context 'when the clipping exists' do
      let(:clipping) { mock_model(Clipping) }

      before { Clipping.stub(:find, clipping) }

      it 'should be successful' do
        get '/api/v1/clippings/43'
        response.status.should == 200
      end
    end
  end

  describe "POST 'api/v1/clippings'" do
    context 'when there are no validation errors' do
      before { Clipping.stub(:create!, Clipping.new) }

      it 'should be successful' do
        post '/api/v1/clippings', {:token => 'token', :content => 'content'}.to_json, { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
        response.status.should == 201
      end
    end

    context 'when there are validation errors' do
      it 'should return error' do
        post '/api/v1/clippings', {}.to_json, { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
        response.status.should == 400
      end
    end
  end

  describe "GET 'api/v1/clippings'" do
    context "when channel exists and has only one clipping" do
      let(:clipping) { stub_model(Clipping, {:token => 'email@domain.com', :content => 'content'}) }

      before do
        clippings = [clipping]
        Clipping.stub_chain([:find_by]).and_return(clippings)
      end

      it 'returns the clipping' do
        get '/api/v1/clippings', nil, { :Channel => 'email@domain.com'}
        response.body.should == clipping.to_json
      end
    end


    context 'When channel exists and has more than one clippings' do
      let(:first_clipping) { stub_model(Clipping, {:created_at => Date.today - 1,:token => 'email@domain.com', :content => 'first content'}) }
      let(:last_clipping) {stub_model(Clipping, {:created_at => Date.today,:token => 'email@domain.com', :content => 'latest content'})}

      before do
        clippings = [ first_clipping, last_clipping ]
        Clipping.stub_chain(:find_by).and_return(clippings)
      end

      it 'returns the last clipping' do
        get '/api/v1/clippings', nil, { :Channel => 'email@domain.com'}
        response.body.should == last_clipping.to_json
      end
    end

    context 'When channel exists and has more than one clippings that are not in order' do
      let(:first_clipping) { stub_model(Clipping, {:created_at => Date.today - 1,:token => 'email@domain.com', :content => 'first content'}) }
      let(:last_clipping) {stub_model(Clipping, {:created_at => Date.today,:token => 'email@domain.com', :content => 'latest content'})}

      before do
        clippings = [ last_clipping, first_clipping]
        Clipping.stub_chain(:find_by).and_return(clippings)
      end

      it 'returns the last clipping' do
        get '/api/v1/clippings', nil, { :Channel => 'email@domain.com' }
        response.body.should == last_clipping.to_json
      end
    end

    context 'When there is no clipping for that channel' do
      before do
        clippings = []
        Clipping.stub_chain(:find_by).and_return(clippings)
      end

      it 'is successful but with null result' do
        get '/api/v1/clippings/', nil, { :Channel => 'email@domain.com' }
        response.body.should == 'null'
      end
    end
  end
end