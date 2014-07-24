window.ShowcasePresenter =
  menuPresenter: window.MenuPresenter
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
      $this.loadedAnimations[edgeAnimation.id].play()

    $("#usecases-wrapper").on 'inview', '.anim-wrap', (event, isInView) ->
      if isInView
        edgeAnimation = $(this).find('.edge-animation')[0]
        if (!$this.loadedAnimations[edgeAnimation.id].played)
          $this.loadedAnimations[edgeAnimation.id].play()

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

    @renderUseCases(availableUsecases)

    return

  edgeDetectionFunction: ->
    if AdobeEdge and AdobeEdge.compositions isnt `undefined`
      hasComposition = false
      if AdobeEdge.compositions
        #loop to see if the composition is actually loaded
        for key of AdobeEdge.compositionDefns
          hasComposition = true
          break
        return
    else if AdobeEdge
      window.onDocLoaded()

    setTimeout @edgeDetectionFunction, 1000
    return

  loadAnimation: (animationId) ->
    $this = $(this)

    @loadedAnimations[animationId] =
      composition: AdobeEdge.getComposition(animationId)
      $container: $("#"+animationId).closest(".anim-wrap")
      played: false

      showReplayButton: ->
        @$container.find('.btn-replay').show()

      hideReplayButton: ->
        @$container.find('.btn-replay').hide()

      play: ->
        @composition.getStage().play()

    AdobeEdge.Symbol.bindTimelineAction(animationId, "stage", "Default Timeline", "play", () ->
      $this[0].loadedAnimations[animationId].played = true;
    )

    AdobeEdge.Symbol.bindTimelineAction(animationId, "stage", "Default Timeline", "stop", (sym, e) ->
      if (e.timeline.currentPosition > 0)
        $this[0].loadedAnimations[animationId].showReplayButton()
    )

  scrollToElement: (el, ms) ->
    $(el).closest(".fp-scrollable").animate(
      { scrollTop: $(el).offset().top }
      , 1000
      , 'easeInQuart')
    $(el).closest(".fp-scrollable").slimScroll({scrollTo: $(el).offset().top})

  renderUseCases: (usecases) ->
    $this = this
    $this.resetAnimations()

    $("#usecases-wrapper").empty()
    _.each(
      usecases,
      (usecase) ->
        template = Handlebars.compile($("#usecase-template").html())
        compiledTemplate = template(usecase)
        $("#usecases-wrapper").append(compiledTemplate)
#        $('#usecases-wrapper').find('.animation').last().height(window.innerHeight)
        $this.edgeDetectionFunction()
        return
    )

    AdobeEdge.bootstrapCallback((compId) ->
      $this.loadAnimation(compId)
    )

    setTimeout(()->
      $this.scrollToElement("#usecases-wrapper")
      return
    , 1000)

    return

  resetAnimations: ->
    $(window).off "animationReady"
    AdobeEdge = undefined;
    @loadedAnimations = {}
    return