module PagesHelper
  def render_welcome
    render partial: (current_user ? 'pages/welcome_logged' : 'pages/welcome_not_logged')
  end

  def render_logged
    render partial: (current_user.early_adopter ? 'pages/welcome_early_adopter' : 'pages/welcome_new_user')
  end

  def devices_options
    ['Windows', 'Windows 8', 'Linux', 'Mac', 'Android', 'IPhone', 'Backberry']
  end

  def winomni_url
    if Rails.env.staging?
      'https://s3.amazonaws.com/omnipaste/win_staging/Omnipaste.application'
    else
      'https://s3.amazonaws.com/omnipaste/win/Omnipaste.application'
    end
  end
end
