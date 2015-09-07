module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    include ScopesHelper
    include MixpanelHelper
    # rubocop:disable Metrics/AbcSize, Metrics/MethodLength

    before_action :set_mixpanel_distinct_id, only: [:google_oauth2]
    before_action :get_identity_info, only: [:google_oauth2]
    after_action :track_user_signup, only: [:google_oauth2]

    def google_oauth2
      @user = handle_authentication(@provided_identity)

      if @user.persisted?
        flash[:notice] = I18n.t('devise.omniauth_callbacks.success', kind: 'Google')
        sign_in_and_redirect @user, event: :authentication
      else
        session['devise.google_data'] = auth
        redirect_to root_url
      end
    end

    def google_oauth2_setup
      existing_scopes = request.env['omniauth.strategy'].options[:scope]

      extend_authorization_scope(existing_scopes) unless scope_already_exists?(existing_scopes)

      render text: 'Scopes changed', status: 404
    end

    private

    def handle_authentication(auth_info)
      OmniApi::UserFactory.ensure_user_exists(auth_info)
      @user = UserFactory.create_or_update(auth_info)
      UpdateUserAccessToken.perform(@user) if @user.access_token_about_to_expire?
      @user
    end

    def get_identity_info
      @provided_identity = request.env['omniauth.auth']
      @provided_identity.scope = request.env['omniauth.strategy'].options[:scope]
      @provided_identity.provider = 'Google'

      @provided_identity
    end

    def track_user_signup
      Track.sign_up(@user.email) if @user.persisted?
    end
  end
end