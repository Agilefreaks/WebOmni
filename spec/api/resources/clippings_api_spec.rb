require 'spec_helper'

describe Resources::ClippingsAPI do
  describe "GET 'api/v1/clippings/:id'" do
    context 'when the clipping doesnt exist' do
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
end