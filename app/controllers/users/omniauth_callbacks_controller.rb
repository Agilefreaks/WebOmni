module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def google_oauth2
      distinct_id = retrieve_id_from_cookie(cookies)
      auth = request.env['omniauth.auth']
      auth[:distinct_id] = distinct_id unless distinct_id.blank?

      @user = find_or_create(auth, current_user)

      if @user.persisted?
        flash[:notice] = I18n.t('devise.omniauth_callbacks.success', :kind => 'Google')
        sign_in_and_redirect @user, :event => :authentication
      else
        session['devise.google_data'] = request.env['omniauth.auth']
        redirect_to root_url
      end
    end

    private

    def find_or_create(auth, signed_in_resource)
      user = signed_in_resource ||
          User.where(email: auth.info.email).first

      UserFactory.from_social(auth, user)
    end

    def retrieve_id_from_cookie(cookies)
      mixpanel_cookie = cookies[:"mp_#{Track.api_key}_mixpanel"] || '{}'
      mixpanel_cookie = JSON.parse(mixpanel_cookie)
      puts mixpanel_cookie.inspect
      mixpanel_cookie['distinct_id'] || ''
    end
  end
end
