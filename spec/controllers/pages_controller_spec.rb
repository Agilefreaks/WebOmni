require 'spec_helper'

describe PagesController do
  describe :welcome do
    subject { get :welcome }

    context 'when user not auth' do
      before do
        allow(controller).to receive(:user_signed_in?).and_return(false)
      end

      it 'will render welcome' do
        subject
        expect(response).to render_template(:welcome)
      end
    end

    context 'when user auth' do
      before do
        allow(controller).to receive(:user_signed_in?).and_return(true)
      end

      it 'will render welcome' do
        subject
        expect(response).to render_template(:welcome_signed_in)
      end
    end

  end
end