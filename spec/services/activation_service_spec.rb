require 'spec_helper'

describe ActivationService do
  let!(:user) { Fabricate(:user) }

  describe '#activate ' do
    let(:activation_token) { Fabricate.build(:activation_token, content: '112233') }
    let(:token) { '112233' }
    let(:device) { 'windows' }

    subject { ActivationService.new.activate(token, device) }

    before do
      user.activation_tokens.push(activation_token)
    end

    context 'with known and valid token' do
      it 'activates the token' do
        expect { subject }.to change { activation_token.reload.used }.from(false).to(true)
      end
    end

    context 'with valid device type' do
      it 'sets the device type' do
        expect { subject }.to change { activation_token.reload.type }.from(:unknown).to(:windows)
      end
    end

    context 'with invalid token id' do
      let(:token) { '111111' }

      it 'raises document not found exception' do
        expect { subject }.to raise_exception(Mongoid::Errors::DocumentNotFound)
      end
    end

    context 'with invalid device type' do
      let(:device) { 'some unsupported' }

      it 'sets the unknown device type' do
        expect { subject }.to_not change { activation_token.reload.type }
      end
    end
  end

  describe '#get_activation_token' do
    subject { ActivationService.new.get_activation_token(user.id) }

    context 'when the user has an unused token' do
      let(:activation_token) { Fabricate.build(:activation_token, content: '112233', used: false) }

      before do
        user.activation_tokens.push(activation_token)
      end

      it "doesn't create a new token" do
        expect { subject }.to_not change { user.reload.activation_tokens.count }
      end

      it 'returns that token' do
        expect(subject._id).to eq activation_token._id
      end
    end

    context "when the user doesn't have an unused token" do
      let(:activation_token) { Fabricate.build(:activation_token, content: '112233', used: true) }

      before do
        user.activation_tokens.push(activation_token)
      end

      it 'generates a new activation_token' do
        expect { subject }.to change { user.reload.activation_tokens.count }.from(1).to(2)
      end
    end
  end
end