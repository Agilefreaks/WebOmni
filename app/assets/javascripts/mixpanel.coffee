$ ->
  $("a[data-trackEvent='true']").click (eventObject) ->
    $target = $(eventObject.target)
    $target = $($target.parent()) if $target.prop('tagName') != 'A'

    category = $target.data('trackcategory') || 'Generic'
    label = $target.data('tracklabel') || $target.data('id')
    value = $target.data('trackvalue')

    mixpanel.track(category)