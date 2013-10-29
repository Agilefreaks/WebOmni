module PricingHelper
  def render_try_free
    render partial: 'pricing/try_free'
  end

  def render_try_free_link(user_signed_in)
    user_signed_in ? (render partial: 'downloads/download_link') : (render partial: 'pricing/sign_up_free')
  end
end
