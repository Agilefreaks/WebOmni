# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$('.popover-link').popover({ html : true, container: 'body' })

$('.popover-link').popover().on 'shown.bs.popover', ->
  $(this).addClass('toggled')

$('.popover-link').popover().on 'hidden.bs.popover', ->
  $(this).removeClass('toggled')

$("body").on "click", (e) ->
  $openedPopoverLink = $(".popover-link.toggled")
  if $openedPopoverLink.has(e.target).length == 0
    $openedPopoverLink.popover "toggle"
    $openedPopoverLink.removeClass "toggled"