window.ShowcaseManager =
  showFor: (device1, device2) ->
    availableUsecases = _.map(
      _.union(
        _.intersection(device1.events, device2.handlers),
        _.intersection(device1.handlers, device2.events)
      ),
      (eventName) ->
        {
        name: eventName
        device1: device1.name
        device2: device2.name
        }
    )
    this.renderUsecases(availableUsecases)

    return

  renderUsecases: (usecases) ->
    $("#usecases-wrapper").empty()
    _.each(
      usecases,
      (usecase) ->
        template = Handlebars.compile($("#usecase_template").html())
        compiledTemplate = template(usecase)
        $("#usecases-wrapper").append(compiledTemplate)
    )

    return