jQuery ($) ->

  Laptop = () -> {
    name: 'Laptop'
    className: 'device-laptop'
    handlers: ['smart clipping', 'incoming call']
    events: ['smart clipping']
    isChecked: true
  }

  Tablet = () -> {
    name: 'Tablet'
    className: 'device-tablet'
    handlers: ['smart clipping', 'incoming call']
    events: ['smart clipping']
    isChecked: false
  }

  Phone = () -> {
    name: 'Phone'
    className: 'device-phone'
    handlers: ['smart clipping']
    events: ['smart clipping', 'incoming call']
    isChecked: false
  }

  TV = () -> {
      name: 'TV'
      className: 'device-tv'
      handlers: []
      events: []
      isChecked: false
    }

  devices = []
  devices.push(Laptop(), Tablet(), Phone(), TV())

  $webOmniApp =
    config:
      $win: $(window)
      $doc: $(document)

      deviceCount: 2
      $devices: devices
      $deviceList: () ->
        $("#devices-wrapper")
      $deviceContinue: $("#device-continue")

      $fullBlock: $(".full-block")
      $menuTrigger: $(".menu-trigger")
      $menuOverlay: $(".menu-overlay")
      $htmlBody: $("html, body")
      $goTo: $(".go-to")
      $lightPanel: $(".light-bg")
      $navBar: $("#header-bar")
      $fullPage: $("#fullpage")
      $btnReplay: $(".btn-replay")
      $slideBack: $(".slide-go-back")
      $slideDown: $(".slide-down")

    getTemplate: ($template) ->
      source = $($template).html()
      template = Handlebars.compile(source)
      template

    resetAnim: ->
      $(window).off "animationReady"
      $("#anim-1-wrap, #anim-2-wrap, #anim-3-wrap, #event-1-wrap, #event-2-wrap").empty()
      return

    setupAnimationView: (template, htmlWrap) ->
      $(htmlWrap).empty()
      window.AdobeEdge = `undefined`
      AdobeEdge = `undefined`
      html = $webOmniApp.getTemplate(template)
      jQuery(htmlWrap).html html
      switch htmlWrap
        when "#anim-1-wrap"
          jQuery("#anim-1-wrap").on "click", ".btn-replay-1", (e) ->
            e.preventDefault()
            AdobeEdge.getComposition("EDGE-88305247").getStage().play "start"
            return

        when "#anim-2-wrap"
          jQuery("#anim-2-wrap").on "click", ".btn-replay-2", (e) ->
            e.preventDefault()
            AdobeEdge.getComposition("EDGE-88305242").getStage().play "start"
            return

        when "#anim-3-wrap"
          jQuery("#anim-3-wrap").on "click", ".btn-replay-3", (e) ->
            e.preventDefault()
            AdobeEdge.getComposition("EDGE-88305243").getStage().play "start"
            return

        when "#event-1-wrap"
          jQuery("#event-1-wrap").on "click", ".btn-replay-4", (e) ->
            e.preventDefault()
            AdobeEdge.getComposition("EDGE-628389270").getStage().play "start"
            return

        when "#event-2-wrap"
          jQuery("#event-2-wrap").on "click", ".btn-replay-5", (e) ->
            e.preventDefault()
            AdobeEdge.getComposition("EDGE-628389271").getStage().play "start"
            return


      #detect if edge is loaded yet
      edgeDetectionFunction = ->
        if AdobeEdge and AdobeEdge.compositions isnt `undefined`

          #put a delay here
          hasComposition = false
          if AdobeEdge.compositions

            #loop to see if the composition is actually loaded
            for key of AdobeEdge.compositionDefns
              hasComposition = true
              break
          if hasComposition
            setTimeout (->
              jQuery(window).trigger "animationReady"
              return
            ), 100
            return
        else window.onDocLoaded()  if AdobeEdge
        setTimeout edgeDetectionFunction, 100
        return

      edgeDetectionFunction()
      return

    mobileCheck: ->
      check = false
      ((a) ->
        check = true  if /(android|ipad|playbook|silk|bb\d+|meego).+mobile|avantgo|bada\/|blackberry|blazer|compal|elaine|fennec|hiptop|iemobile|ip(hone|od)|iris|kindle|lge |maemo|midp|mmp|netfront|opera m(ob|in)i|palm( os)?|phone|p(ixi|re)\/|plucker|pocket|psp|series(4|6)0|symbian|treo|up\.(browser|link)|vodafone|wap|windows (ce|phone)|xda|xiino/i.test(a) or /1207|6310|6590|3gso|4thp|50[1-6]i|770s|802s|a wa|abac|ac(er|oo|s\-)|ai(ko|rn)|al(av|ca|co)|amoi|an(ex|ny|yw)|aptu|ar(ch|go)|as(te|us)|attw|au(di|\-m|r |s )|avan|be(ck|ll|nq)|bi(lb|rd)|bl(ac|az)|br(e|v)w|bumb|bw\-(n|u)|c55\/|capi|ccwa|cdm\-|cell|chtm|cldc|cmd\-|co(mp|nd)|craw|da(it|ll|ng)|dbte|dc\-s|devi|dica|dmob|do(c|p)o|ds(12|\-d)|el(49|ai)|em(l2|ul)|er(ic|k0)|esl8|ez([4-7]0|os|wa|ze)|fetc|fly(\-|_)|g1 u|g560|gene|gf\-5|g\-mo|go(\.w|od)|gr(ad|un)|haie|hcit|hd\-(m|p|t)|hei\-|hi(pt|ta)|hp( i|ip)|hs\-c|ht(c(\-| |_|a|g|p|s|t)|tp)|hu(aw|tc)|i\-(20|go|ma)|i230|iac( |\-|\/)|ibro|idea|ig01|ikom|im1k|inno|ipaq|iris|ja(t|v)a|jbro|jemu|jigs|kddi|keji|kgt( |\/)|klon|kpt |kwc\-|kyo(c|k)|le(no|xi)|lg( g|\/(k|l|u)|50|54|\-[a-w])|libw|lynx|m1\-w|m3ga|m50\/|ma(te|ui|xo)|mc(01|21|ca)|m\-cr|me(rc|ri)|mi(o8|oa|ts)|mmef|mo(01|02|bi|de|do|t(\-| |o|v)|zz)|mt(50|p1|v )|mwbp|mywa|n10[0-2]|n20[2-3]|n30(0|2)|n50(0|2|5)|n7(0(0|1)|10)|ne((c|m)\-|on|tf|wf|wg|wt)|nok(6|i)|nzph|o2im|op(ti|wv)|oran|owg1|p800|pan(a|d|t)|pdxg|pg(13|\-([1-8]|c))|phil|pire|pl(ay|uc)|pn\-2|po(ck|rt|se)|prox|psio|pt\-g|qa\-a|qc(07|12|21|32|60|\-[2-7]|i\-)|qtek|r380|r600|raks|rim9|ro(ve|zo)|s55\/|sa(ge|ma|mm|ms|ny|va)|sc(01|h\-|oo|p\-)|sdk\/|se(c(\-|0|1)|47|mc|nd|ri)|sgh\-|shar|sie(\-|m)|sk\-0|sl(45|id)|sm(al|ar|b3|it|t5)|so(ft|ny)|sp(01|h\-|v\-|v )|sy(01|mb)|t2(18|50)|t6(00|10|18)|ta(gt|lk)|tcl\-|tdg\-|tel(i|m)|tim\-|t\-mo|to(pl|sh)|ts(70|m\-|m3|m5)|tx\-9|up(\.b|g1|si)|utst|v400|v750|veri|vi(rg|te)|vk(40|5[0-3]|\-v)|vm40|voda|vulc|vx(52|53|60|61|70|80|81|83|85|98)|w3c(\-| )|webc|whit|wi(g |nc|nw)|wmlb|wonu|x700|yas\-|your|zeto|zte\-/i.test(a.substr(0, 4))
        return
      ) navigator.userAgent or navigator.vendor or window.opera
      check

    appendHome: ->
      window.location.hash = "#home"  unless window.location.hash
      return

    callbacks:
      toggleMenu: ->
        $this = $(this)
        if $this.hasClass("active")
          $webOmniApp.callbacks.closeMenu()
        else
          $webOmniApp.callbacks.openMenu()
        return

      openMenu: ->
        $webOmniApp.config.$menuTrigger.addClass "active"
        $webOmniApp.config.$menuOverlay.addClass "open"
        return

      closeMenu: (e) ->
        $this = $(this)
        if $(window).width() < 600
          e.preventDefault()
          blockId = $this.data("id")
          $webOmniApp.callbacks.goToBlock blockId
        $webOmniApp.config.$menuTrigger.removeClass "active"
        $webOmniApp.config.$menuOverlay.removeClass "open"
        return

      goToBlock: (id) ->
        $("html, body").animate
          scrollTop: $(id).offset().top
        , 1000
        return

      toggleDevice: ->
        $this = $(this)
        $parent = $this.closest("#device-list")
        if $parent.find("input:checked").length is $webOmniApp.config.deviceCount
          $parent.find(":not(input:checked)").prop("disabled", true).end().closest("form").find("#device-continue").prop "disabled", false

          #disable tooltip
          $("#device-disabled-wrap").tooltip "destroy"
        else
          $parent.find("input:disabled").prop("disabled", false).end().closest("form").find("#device-continue").prop "disabled", true

          #enable tooltip
          $("#device-disabled-wrap").tooltip()
        return

      goTo: (e) ->
        e.preventDefault()
        $.fn.fullpage.moveSectionDown()
        return

      goBack: (e) ->
        e.preventDefault()
        $.fn.fullpage.moveSlideRight()
        return

      showUsecasesForSelectedDevices: ->
        $webOmniApp.resetAnim()
        checkedDevices = _.pluck($("#device-list").find("input:checked"), 'name')

        selectedDevices = _.filter($webOmniApp.config.$devices, (device) ->
          _.contains(checkedDevices, device.name))

        availableUsecases = _.union(
          _.intersection(selectedDevices[0].events, selectedDevices[1].handlers),
          _.intersection(selectedDevices[0].handlers, selectedDevices[1].events)
        )

        renderUsecases(selectedDevices, availableUsecases)

        return

    attachHandles: ->
      @config.$win.resize $webOmniApp.callbacks.resize
      @config.$menuTrigger.on "click", $webOmniApp.callbacks.toggleMenu
      @config.$menuOverlay.on "click", "a", $webOmniApp.callbacks.closeMenu
      @config.$deviceList().on "change", "input", $webOmniApp.callbacks.toggleDevice
      @config.$goTo.on "click", $webOmniApp.callbacks.goTo
      @config.$slideBack.on "click", $webOmniApp.callbacks.goBack
      @config.$deviceContinue.on "click", $webOmniApp.callbacks.showUsecasesForSelectedDevices
      @config.$goToEvent.on "click", $webOmniApp.callbacks.goToEvent
      return

    appPlugins:
      initFullPage: ->
        $container = $webOmniApp.config.$fullPage
        if $container.length
          $container.fullpage
            verticalCentered: true
            scrollOverflow: true
            navigation: true
            anchors: [
              "home"
              "seemore"
              "feedback"
              "team"
            ]
            loopHorizontal: false
            resize: false
            css3: true
            easing: "easeInQuart"
            onLeave: (index, nextIndex) ->
              if $(".section").eq(nextIndex - 1).hasClass("light-bg")
                $("#header-bar").addClass "styled"
              else
                $("#header-bar").removeClass "styled"
              window.location.hash = "#seemore"  if nextIndex is "2"
              return

            afterSlideLoad: (anchorLink, index, slideAnchor, slideIndex) ->
              if slideIndex is 0
                $("#header-bar").addClass "styled"
              else
                $("#header-bar").removeClass "styled"
              return

            afterRender: () ->
              devicesTemplate = $("#devices-template").html()
              template = Handlebars.compile(devicesTemplate)
              $("#devices-wrapper").append template({ devices: $webOmniApp.config.$devices})

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
      return

  $webOmniApp.init()
  return
