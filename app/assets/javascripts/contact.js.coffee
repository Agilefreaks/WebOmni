# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$('#contact_call').click (event) ->
  phoneNumber = $(this).data('phone-number')
  email = $(this).data('email')
  rootUrl = $(this).data('root-url')

  innerHTML = this.innerHTML
  this.innerHTML = 'Calling'

  $.ajax {
    type: 'POST',
    url: rootUrl + "api/v1/devices/call",
    headers: {'Channel': email},
    dataType: 'json'
    data: {
      phone_number: phoneNumber,
      registrationId: 'web'
    }
  }

  event.preventDefault