module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    # rubocop:disable Metrics/AbcSize, Metrics/MethodLength

    before_action :set_mixpanel_distinct_id, only: [:google_oauth2]

    def google_oauth2
      auth = request.env['omniauth.auth']
      @user = find_or_create(auth, current_user)

      if @user.persisted?
        Track.sign_up(auth.info.email)
        flash[:notice] = I18n.t('devise.omniauth_callbacks.success', kind: 'Google')
        sign_in_and_redirect @user, event: :authentication
      else
        session['devise.google_data'] = auth
        redirect_to root_url
      end
    end

    def google_oauth2_setup
      request.env['omniauth.strategy'].options[:scope] = [request.env['omniauth.strategy'].options[:scope], session[:google_permissions]].join(',').chomp(',')

      render :text => 'Scopes changed', :status => 404
    end


    private
    def find_or_create(auth, signed_in_resource)
      user = current_user ||
             User.where(email: auth.info.email.downcase).first

      UserFactory.from_social(auth, user)
    end

    def set_mixpanel_distinct_id
      distinct_id = retrieve_id_from_cookie(cookies)
      auth = request.env['omniauth.auth']
      auth[:distinct_id] = distinct_id unless distinct_id.blank?
      auth[:remote_ip] = request.remote_ip
    end

    def retrieve_id_from_cookie(cookies)
      mixpanel_cookie = cookies[:"mp_#{Track.api_key}_mixpanel"] || '{}'
      mixpanel_cookie = JSON.parse(mixpanel_cookie)
      mixpanel_cookie['distinct_id'] || ''
    end
  end
end
