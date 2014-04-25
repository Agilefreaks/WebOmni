class MenuCell < Cell::Rails
  build do
    UnauthorizedMenuCell unless user_signed_in?
  end

  def show
    render
  end
end
