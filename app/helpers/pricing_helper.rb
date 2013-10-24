module PricingHelper
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
