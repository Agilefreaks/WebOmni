module MixpanelHelper
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