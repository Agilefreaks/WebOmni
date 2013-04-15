require 'spec_helper'

describe Api::ActivationController do
  it { should respond_to(:activate) }

  describe "#activate" do
    context "action receives correct token" do
      subject { get :activate, :token => "testToken", :format => :json}

      it "should return a valid activation data object if given token is correct" do
        subject

        response.body.should == '{"activation_data":{"channel":"test"}}'
      end
    end

    context "action does not receive correct token" do
      subject { get :activate, :token => "testToken2", :format => :json}

      it "should return an error message" do
        subject

        response.body.should == '{"activation_data":{"errors":"Token not found"}}'
      end
    end
  end
end