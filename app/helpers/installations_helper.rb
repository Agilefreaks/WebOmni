module InstallationsHelper
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
end
