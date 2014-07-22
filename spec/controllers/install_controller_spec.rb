require 'spec_helper'

describe InstallController do
  describe "GET 'show'" do
    subject { get :show, id: step }

    context 'for :login' do
      let(:step) { :login }

      context 'when user is signed_in' do
        include_context :logged_in_as_user

        it 'will redirect to device selection' do
          expect(subject).to redirect_to(install_path(:devices_selection))
        end
      end

      context 'when user is not signed_in' do
        it 'will render login' do
          expect(subject).to render_template('install/login')
        end
      end
    end
  end
end
