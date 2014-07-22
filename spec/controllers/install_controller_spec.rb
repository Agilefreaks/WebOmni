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

    context 'for :devices_selection' do
      include_context :logged_in_as_user

      let(:step) { :devices_selection }

      it 'will assign a wizard' do
        subject
        expect(assigns(:wizard)).to be_a_new(Wizard)
      end
    end

    context 'for :finish' do
      include_context :logged_in_as_user

      let(:step) { :finish }

      it 'will delete the wizard on user' do
        current_user.create_wizard
        subject
        expect(current_user.wizard).to be_nil
      end
    end
  end

  describe "PUT 'update'" do
    include_context :logged_in_as_user

    let(:params) { {} }

    subject { put :update, params.merge({ id: 'devices_selection' }) }

    context 'when params contains phone' do
      let(:params) { { :'phone' => 'on' } }

      it 'will add the phone to the list of steps' do
        subject
        expect(current_user.wizard.devices).to include(:phone)
      end
    end

    context 'when params contains laptop' do
      let(:params) { { :'tablet' => 'on' } }

      it 'will add the tablet to the list of steps' do
        subject
        expect(current_user.wizard.devices).to include(:tablet)
      end
    end

    it 'will redirect to device_selection' do
      expect(subject).to redirect_to(install_path(:devices_selection))
    end
  end
end

