jQuery ($) ->
  $webOmniApp =
    showcasePresenter: window.ShowcasePresenter
    devicesPresenter: window.DevicesPresenter
    menuPresenter: window.MenuPresenter

    config:
      $win: $(window)
      $doc: $(document)
      $devicesWrapper: $("#devices-wrapper")
      $fullPage: $("#fullpage")
      $showUsecases: $("#device-continue")

    getTemplate: ($template) ->
      source = $($template).html()
      template = Handlebars.compile(source)
      template

    appendHome: ->
      window.location.hash = "#home"  unless window.location.hash
      return

    callbacks:
      goTo: (e) ->
        e.preventDefault()
        $.fn.fullpage.moveSectionDown()
        return

      showUsecasesForSelectedDevices: ->
        selectedDevices = $webOmniApp.devicesPresenter.getSelectedDevices()
        $webOmniApp.showcasePresenter.showFor(selectedDevices[0], selectedDevices[1])
        $webOmniApp.config.$fullPage.fullpage.reBuild()

        return

    attachHandles: ->
      @config.$win.resize $webOmniApp.callbacks.resize
      @config.$showUsecases.on "click", $webOmniApp.callbacks.showUsecasesForSelectedDevices
      return

    appPlugins:
      initFullPage: ->
        $container = $webOmniApp.config.$fullPage
        $container.fullpage
          anchors: ["home", "seemore", "feedback", "team"]
          scrollOverflow: true
          verticalCentered: false
          resize: false

          onLeave: (index, nextIndex) ->
            if $(".fp-section").eq(nextIndex - 1).hasClass("light-bg")
              $("#header-bar").addClass "styled"
            else
              $("#header-bar").removeClass "styled"
            return

          afterRender: () ->
            $webOmniApp.devicesPresenter.showDevices()

            $webOmniApp.attachHandles()

        return

      initBootstrapTooltip: ->
        $("[data-toggle=tooltip]").tooltip()
        return

      init: ->
        @initBootstrapTooltip()
        @initFullPage()  if $(window).width() > 600
        return

    init: ->
      @appendHome()  if $(window).width() > 600
      @appPlugins.init()
      @showcasePresenter.init()
      @menuPresenter.init()

      return

  $webOmniApp.init()
  return