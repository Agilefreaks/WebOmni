class MenuCell < Cell::Rails

  def show(args)
    @user = args[:user]
    @menu = @user ? 'authorized' : 'unauthorized'
    render
  end

end
