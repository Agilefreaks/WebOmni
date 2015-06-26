module ScopesHelper
  def extend_authorization_scope(existing_scopes)
    if existing_scopes.blank?
      request.env['omniauth.strategy'].options[:scope] = session[:google_permissions]
    else
      request.env['omniauth.strategy'].options[:scope] = existing_scopes + ',' + session[:google_permissions]
    end

    session[:google_permissions] = ''
  end

  def scope_already_exists?(existing_scopes)
    session[:google_permissions].blank? || existing_scopes.include?(session[:google_permissions])
  end
end
