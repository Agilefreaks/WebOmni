require 'spec_helper'

describe ActivationService do
  let!(:user) { Fabricate(:user) }

  describe :get_activation_token do
    subject { ActivationService.get_activation_token(user.id) }

    context 'when the user has an unused token' do
      let(:used_activation_token) { Fabricate.build(:activation_token, content: '42', used: true) }
      let(:activation_token) { Fabricate.build(:activation_token, content: '112233', used: false) }

      before do
        user.activation_tokens.push(used_activation_token)
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