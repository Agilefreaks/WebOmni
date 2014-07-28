jQuery ($) ->
  $webOmniApp =
    menuPresenter: window.MenuPresenter

    appendHome: ->
      window.location.hash = "#home"  unless window.location.hash
      return

    init: ->
      @appendHome()  if $(window).width() > 600
      @menuPresenter.init()
      return

  $webOmniApp.init()
  return