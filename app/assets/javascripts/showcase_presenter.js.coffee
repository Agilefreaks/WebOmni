window.ShowcasePresenter =
  events:
    'incoming-call': {id: 'incoming_call', displayName: 'Incoming Call'}
    'navigation': {id: 'navigation', displayName: 'Smart clipping - Navigation'}

  loadedAnimations: {}

  init: () ->
    $this = $(this)[0]

    $("#usecases-wrapper").on 'click', '.btn-replay', (e) ->
      e.preventDefault()
      animationContainer = $(this).closest('.animation')
      edgeAnimation = animationContainer.find('.edge-animation')[0]
      AdobeEdge.getComposition(edgeAnimation.id).getStage().play "start"
      return

    $("#usecases-wrapper").on 'inview', '.anim-wrap', (event, isInView) ->
      if isInView
        edgeAnimation = $(this).find('.edge-animation')[0]
        if (!$this.loadedAnimations[edgeAnimation.id].played)
          AdobeEdge.getComposition(edgeAnimation.id).getStage().play "start"
      return

    return

  showFor: (device1, device2) ->
    events = @events
    availableUsecases = _.map(
      _.union(
        _.intersection(device1.events, device2.handlers),
        _.intersection(device1.handlers, device2.events)
      ),
      (eventName) ->
        if _.contains(device1.events, eventName)
          emitterDevice = device1.id
          handlerDevice = device2.id
        else
          emitterDevice = device2.id
          handlerDevice = device1.id
        event: events[eventName]
        device1: emitterDevice
        device2: handlerDevice
    )

    @renderUsecases(availableUsecases)

    return

  edgeDetectionFunction: ->
    if AdobeEdge and AdobeEdge.compositions isnt `undefined`
      hasComposition = false
      if AdobeEdge.compositions
        #loop to see if the composition is actually loaded
        for key of AdobeEdge.compositionDefns
          hasComposition = true
          break
      if hasComposition
        setTimeout(()->
          jQuery(window).trigger "animationReady"
          return
        , 100)
        return
    else if AdobeEdge
      window.onDocLoaded()

    setTimeout @edgeDetectionFunction, 1000
    return

  renderUsecases: (usecases) ->
    $this = this
    $this.resetAnim()

    $("#usecases-wrapper").empty()
    _.each(
      usecases,
      (usecase) ->
        template = Handlebars.compile($("#usecase_template").html())
        compiledTemplate = template(usecase)
        $("#usecases-wrapper").append(compiledTemplate)
        $this.edgeDetectionFunction()
        return
    )

    AdobeEdge.bootstrapCallback((compId) ->
      $this.loadedAnimations[compId] = {
        composition: AdobeEdge.getComposition(compId)
      }

      AdobeEdge.Symbol.bindTimelineAction(compId, "stage", "Default Timeline", "play", () ->
        $this.loadedAnimations[compId].played = true;
      )
      AdobeEdge.Symbol.bindTimelineAction(compId, "stage", "Default Timeline", "complete", () ->
      )

      $this.loadedAnimations[compId] = {
        composition: AdobeEdge.getComposition(compId)
      }
    )

    return

  resetAnim: ->
    $(window).off "animationReady"
    AdobeEdge = undefined;
    @loadedAnimations = {}
    return