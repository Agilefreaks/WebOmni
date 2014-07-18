window.ShowcasePresenter =
  events:
    'incoming-call': {id: 'incoming_call', displayName: 'Incoming Call'}
    'navigation': {id: 'navigation', displayName: 'Smart clipping - Navigation'}

  showFor: (device1, device2) ->
    events = @events
    availableUsecases = _.map(
      _.union(
        _.intersection(device1.events, device2.handlers),
        _.intersection(device1.handlers, device2.events)
      ),
      (eventName) ->
        event: events[eventName]
        device1: device1.id
        device2: device2.id
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

        $("#usecases-wrapper").last('.btn-replay').on "click", (e) ->
          e.preventDefault()
          AdobeEdge.getComposition(string.concat(usecase.id, '_', usecase.device1, '_',usecase.device2)).getStage().play "start"
          return

        $this.edgeDetectionFunction()
        return
    )

    return

  resetAnim: ->
    $(window).off "animationReady"
    window.AdobeEdge = undefined;
    AdobeEdge = undefined;
    return