$ ->
  $("a[data-track='trackEvent']").click (eventObject) ->
    $target = $(eventObject.target)
    category = $target.data('category') || 'Generic'
    label = $target.data('id')
    value = $target.data('value')
    non_interaction = $target.data('noninteraction')

    _gaq.push(['_trackEvent', category, label, value, non_interaction])