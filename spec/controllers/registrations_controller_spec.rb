require 'spec_helper'

describe RegistrationsController do

  describe "GET 'startupchile'" do
    it 'returns http success' do
      get 'startupchile'
      expect(response).to be_success
    end
  end

end
