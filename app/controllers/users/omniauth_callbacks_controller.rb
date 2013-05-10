class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = find_or_create(request.env['omniauth.auth'], current_user)

    if @user.persisted?
      flash[:notice] = I18n.t("devise.omniauth_callbacks.success", :kind => "Google")
      sign_in_and_redirect @user, :event => :authentication
    else
      session['devise.google_data'] = request.env['omniauth.auth']
      redirect_to root_url
    end
  end

  private

  def find_or_create(auth, signed_in_resource)
    user = signed_in_resource ||
        User.find_by_provider(auth.info.email, auth.provider) ||
        User.where(:email => auth.info.email).first

    UserFactory.from_social(auth, user)
  end
end