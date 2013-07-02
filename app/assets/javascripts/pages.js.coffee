# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$('#demo').on('hide', ->
  url = $('#demo_frame').attr('src')
  $('#demo_frame').attr('src', '')
  $('#demo_frame').attr('src', url)
)

$('#windows_download_redirect_link').click(->
  _gaq.push(['_trackEvent', 'Download', 'Windows', $("#windows_download_link").data('user')])

  document.getElementById('windows_download_link').click()
  redirectUrl = $(this).data('redirect')

  setTimeout((->
    window.location.href = redirectUrl),
    1000
  )

  return false;
)

$("#android_download_link").click(->
  _gaq.push(['_trackEvent', 'Download', 'Android', $("#android_download_link").data('user')])
  console.log('Logged')
)