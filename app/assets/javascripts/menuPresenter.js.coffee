window.MenuPresenter =
  $menuTrigger: $(".menu-trigger")
  $menuOverlay: $(".menu-overlay")

  toggleMenu: ->
    $this = $(this)
    if $this.hasClass("active")
      window.MenuPresenter.closeMenu()
    else
      window.MenuPresenter.openMenu()
    return

  openMenu: ->
    @$menuTrigger.addClass "active"
    @$menuOverlay.addClass "open"
    return

  closeMenu: (e) ->
    $this = $(this)
    if $(window).width() < 600
      e.preventDefault()
      blockId = $this.data("id")
      window.MenuPresenter.goToBlock blockId
    window.MenuPresenter.$menuTrigger.removeClass "active"
    window.MenuPresenter.$menuOverlay.removeClass "open"
    return

  goToBlock: (id) ->
    $("html, body").animate
      scrollTop: $(id).offset().top
    , 1000
    return

  init: () ->
    @$menuTrigger.on "click", @toggleMenu
    @$menuOverlay.on "click", "a", @closeMenu