# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$('#demo').on('hide', ->
  url = $('#demo_frame').attr('src')
  $('#demo_frame').attr('src', '')
  $('#demo_frame').attr('src', url)
)