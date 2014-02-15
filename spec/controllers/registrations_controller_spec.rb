require 'spec_helper'
require 'rspec-rails'

describe RegistrationsController do

  shared_examples_for 'partner site' do |partner, welcome|
    before :each do
      get partner
    end

    its('response.status') { should eq(200) }

    it 'assigns welcome' do
      expect(assigns(:welcome)).to eq welcome
    end

    it 'assigns partner cookie' do
      expect(response.cookies['partner']).to eq 'true'
    end
  end

  describe "GET 'startupchile'" do
    it_behaves_like 'partner site', :startupchile, 'Hi there Startup Chile folks, glad you dropped by.'
  end

  describe "GET 'soft32'" do
    it_behaves_like 'partner site', :soft32, 'Hi there Soft32 visitor, glad you dropped by.'
  end
end
