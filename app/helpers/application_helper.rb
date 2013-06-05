module ApplicationHelper  
  def render_about
    render partial: 'layouts/about'
  end

  def render_team
    render partial: 'layouts/team'
  end

  def render_contact
    render partial: 'layouts/contact'
  end
end