require 'spec_helper'

describe OmniApi::User do
  it { should respond_to :first_name }
  it { should respond_to :last_name }

  describe :element_path do
    subject { OmniApi::User.element_path('1') }

    it { should == '/api/v1/users/1' }
  end

  let(:user) { OmniApi::User.new(id: '1') }

  describe :change_plan! do
    context 'to premium' do
      before do
        ActiveResource::HttpMock.respond_to do |mock|
          mock.put '/api/v1/users/premium', { 'Content-Type' => 'application/json', 'Authorization' => 'bearer random' }, 'email' => 'email@domain.com'
        end
      end

      subject { OmniApi::User.change_plan!('email@domain.com', :premium) }

      it('makes the api call to make the user a premium user') { should.nil? }
    end

    context 'to_basic' do
      before do
        ActiveResource::HttpMock.respond_to do |mock|
          mock.put '/api/v1/users/basic', { 'Content-Type' => 'application/json', 'Authorization' => 'bearer random' }, 'email' => 'email@domain.com'
        end
      end

      subject { OmniApi::User.change_plan!('email@domain.com', :basic) }

      it('makes the api call to make the user a basic user') { should.nil? }
    end
  end
end
