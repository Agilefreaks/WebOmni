require 'spec_helper'

describe PagesController do
  describe 'welcome' do
    subject { get :welcome }

    context 'when user not authenticated' do
      before do
        allow(controller).to receive(:user_signed_in?).and_return(false)
      end

      it 'will render welcome' do
        subject
        expect(response).to render_template(:welcome)
      end
    end

    context 'when user authenticated' do
      before do
        allow(controller).to receive(:user_signed_in?).and_return(true)
      end

      it 'will render welcome' do
        subject
        expect(response).to render_template(:welcome_signed_in)
      end
    end

    context 'HTTP_ACCEPT_LANGUAGE is set' do
      context 'to one of the valid languages' do
        before :each do
          request.env['HTTP_ACCEPT_LANGUAGE'] = 'pt'
        end

        it 'will set it to I18n.locale' do
          subject
          expect(I18n.locale).to eq :pt
        end
      end

      context 'to a language not valid' do
        before :each do
          request.env['HTTP_ACCEPT_LANGUAGE'] = 'an'
        end

        it 'will default to :en' do
          subject
          expect(I18n.locale).to eq :en
        end
      end
    end
  end

  describe 'user_access_token' do
    subject { get :user_access_token }

    context 'when user authenticated' do
      include_context :logged_in_as_user

      it 'will render user_access_token' do
        subject
        expect(response).to render_template(:user_access_token)
      end
    end

    context 'when user not authenticated' do
      it 'will redirect the user to the login page' do
        subject
        expect(response).to redirect_to(new_user_session_path(locale: ''))
      end
    end
  end
end
