window.ShowcaseManager =
  events: {
    'incoming-call': {id: 'incoming-call', displayName: 'Incoming Call'}
    'navigation': {id: 'navigation', displayName: 'Smart clipping - Navigation'}
  }

  showFor: (device1, device2) ->
    events = @events
    availableUsecases = _.map(
      _.union(
        _.intersection(device1.events, device2.handlers),
        _.intersection(device1.handlers, device2.events)
      ),
      (eventName) ->
        event: events[eventName]
        device1: device1.name
        device2: device2.name
    )
    this.renderUsecases(availableUsecases)

    return

  renderUsecases: (usecases) ->
    @resetAnim()

    $("#usecases-wrapper").empty()
    _.each(
      usecases,
      (usecase) ->
        template = Handlebars.compile($("#usecase_template").html())
        compiledTemplate = template(usecase)
        $("#usecases-wrapper").append(compiledTemplate)
    )

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

  resetAnim: ->
    $(window).off "animationReady"
    return