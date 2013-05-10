class MenuCell < Cell::Rails

  def show(params)
    @current_user = params[:user]
    render view: @current_user ? 'logged' : 'not_logged'
  end

end
