jQuery () ->
  $webOmniApp =
    menuPresenter: window.MenuPresenter

    init: ->
      @menuPresenter.init()
      return

  $webOmniApp.init()
  return