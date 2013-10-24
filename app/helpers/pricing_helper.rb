module PricingHelper
  def render_try_free
    render partial: 'pricing/try_free'
  end

  def render_try_free_link(user_signed_in)
    user_signed_in ? (render partial: 'downloads/download_link') : (render partial: 'pricing/sign_up_free')
  end
  
  def render_smart_actions
    render partial: 'pricing/smart_actions'
  end

  def render_clippings_history
    render partial: 'pricing/clippings_history'
  end

  def render_file_transfer
    render partial: 'pricing/file_transfer'
  end
end
