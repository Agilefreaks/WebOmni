require 'spec_helper'

describe SdkController do
  describe 'GET #show' do
    it 'returns http success' do
      get :show, id: '5385e2db6465762d96000000', format: :js
      expect(response).to have_http_status(:success)
    end
  end
end
