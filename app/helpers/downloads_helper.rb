module DownloadsHelper
  def android_url
    if Rails.env.staging?
      'http://cdn.omnipasteapp.com/staging/android/omnipaste.apk'
    else
      'http://cdn.omnipasteapp.com/production/android/omnipaste.apk'
    end
  end

  def render_windows_client
    render partial: 'downloads/download_windows'
  end

  def render_linux_client
    render partial: 'downloads/download_linux' if !!(user_agent(request.env['HTTP_USER_AGENT']).os =~ (/Linux/i))
  end

  def render_mac_client
    render partial: 'downloads/download_mac' if !!(user_agent(request.env['HTTP_USER_AGENT']).os =~ (/Macintosh/i))
  end

  def render_android_client
    render partial: 'downloads/download_android'
  end

  private

  def user_agent(string)
    UserAgent.parse(string)
  end
end
