require 'spec_helper'

describe RegistrationsController do

  describe "GET 'startupchile'" do
    before :each do
      get :startupchile
    end

    it { should respond_with(200) }

    it 'assigns welcome' do
      expect(assigns(:welcome)).to eq 'Hi there Startup Chile folks, glad you dropped by.'
    end

    it 'assigns state' do
      expect(assigns(:state)).to eq :chile
    end
  end

  describe "GET 'soft32'" do
    before :each do
      get :soft32
    end

    it { should respond_with(200) }

    it 'assigns welcome' do
      expect(assigns(:welcome)).to eq 'Hi there Soft32 visitor, glad you dropped by.'
    end

    it 'assigns state' do
      expect(assigns(:state)).to eq :soft32
    end
  end
end
