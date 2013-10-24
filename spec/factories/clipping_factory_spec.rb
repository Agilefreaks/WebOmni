require 'spec_helper'

describe ClippingFactory do
  describe 'create' do
    subject { ClippingFactory.create(content: content, token: 'token') }

    context 'when content is string' do
      let(:content) { 'some' }

      it 'will add a new clipping' do
        expect { subject }.to change(Clipping, :count).by(1)
      end

      it 'will add a clipping with unknown type' do
        subject
        expect(Clipping.last.type).to eq(:unknown)
      end
    end

    context 'when content is phone' do
      let(:content) { '+40745857479' }

      it 'will add a clipping with phone_number type' do
        subject
        expect(Clipping.last.type).to eq(:phone_number)
      end
    end

    context 'when content is https link' do
      let(:content) { 'https://news.ycombinator.com/item?id=6602902' }

      it 'saves the correct content' do
        subject
        expect(Clipping.last.content).to eq('https://news.ycombinator.com/item?id=6602902')
      end
    end
  end
end