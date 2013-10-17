module PagesHelper
  def render_logon
    render partial: (current_user ? 'pages/welcome_logged' : 'pages/welcome_not_logged')
  end

  def render_logged
    render partial: (current_user.early_adopter ? 'pages/welcome_early_adopter' : 'pages/welcome_new_user')
  end

  def devices_options
    ['Windows', 'Windows 8', 'Linux', 'Mac', 'Android', 'IPhone', 'Blackberry']
  end

  def winomni_url
    if Rails.env.staging?
      'http://cdn.omnipasteapp.com/staging/win/Omnipaste-staging.application'
    else
      'https://s3.amazonaws.com/omnipaste-production/win/Omnipaste.application'
    end
  end

  def android_url
    if Rails.env.staging?
      'http://cdn.omnipasteapp.com/staging/android/omnipaste.apk'
    else
      'https://s3.amazonaws.com/omnipaste-production/android/omnipaste.apk'
    end
  end

  def render_windows_client
    render partial: 'pages/windows_client' if !!(user_agent(request.env['HTTP_USER_AGENT']).os =~ (/Windows/i))
  end

  def render_linux_client
    render partial: 'pages/linux_client' if !!(user_agent(request.env['HTTP_USER_AGENT']).os =~ (/Linux/i))
  end

  def render_mac_client
    render partial: 'pages/mac_client' if !!(user_agent(request.env['HTTP_USER_AGENT']).os =~ (/Macintosh/i))
  end

  def installation_url
    if !!(user_agent(request.env['HTTP_USER_AGENT']).browser =~ (/Chrome/i))
      installations_chrome_url
    elsif !!(user_agent(request.env['HTTP_USER_AGENT']).browser =~ (/Firefox/i))
      installations_firefox_url
    elsif !!(user_agent(request.env['HTTP_USER_AGENT']).browser =~ (/Internet Explorer/i))
      installations_ie_url
    else
      installations_default_url
    end
  end

  def render_android_client
    render partial: 'pages/android_client'
  end

  private

  def user_agent(string)
    UserAgent.parse(string)
  end
end
