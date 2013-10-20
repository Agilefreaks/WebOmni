require 'spec_helper'

describe RegistrationsController do

  describe "GET 'startupchile'" do
    before :each do
      get :startupchile
    end

    it { should respond_with(200) }

    it { assigns(:welcome).should == 'Hi there Startup Chile folks, glad you dropped by, Omnipaste is a clipboard manager in the cloud and works like your short-term memory.' }

    it { assigns(:state).should == :chile }
  end

  describe "GET 'soft32'" do
    before :each do
      get :soft32
    end

    it { should respond_with(200) }

    it { assigns(:welcome).should == 'Hi there soft32 visitor, glad you dropped by, Omnipaste is a clipboard manager in the cloud and works like your short-term memory.' }

    it { assigns(:state).should == :soft32 }
  end
end
