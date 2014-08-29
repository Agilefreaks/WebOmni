$ ->
  $("a[data-trackEvent='true']").click (eventObject) ->
    $target = $(eventObject.target)
    category = $target.data('trackcategory') || 'Generic'
    label = $target.data('tracklabel') || $target.data('id')
    value = $target.data('trackvalue')
    non_interaction = $target.data('tracknoninteraction')

    _gaq.push(['_trackEvent', category, label, value, non_interaction])