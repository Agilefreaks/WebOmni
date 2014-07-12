window.DevicesManager =
  $devicesWrapper: $("#devices-wrapper")

  devices: [
    { name: 'Laptop', className: 'device-laptop', handlers: ['navigation', 'incoming-call'], events: ['navigation'] }
    { name: 'Tablet', className: 'device-tablet', handlers: ['navigation', 'incoming-call'], events: ['navigation'], isChecked: false }
    { name: 'Phone', className: 'device-phone', handlers: ['navigation'], events: ['navigation', 'incoming-call'], isChecked: false }
    { name: 'TV', className: 'device-tv', handlers: [], events: [], isChecked: false }
  ]

  showDevices: () ->
    $devicesWrapper = $("#devices-wrapper")
    devicesTemplate = $("#devices-template").html()
    template = Handlebars.compile(devicesTemplate)
    $devicesWrapper.append template({ devices: @devices})
    $devicesWrapper.on "change", "input", @toggleDevice

  toggleDevice: () ->
    $devicesWrapper = $("#devices-wrapper")
    if $devicesWrapper.find("input:checked").length > 1
      $devicesWrapper
      .find("input:not(input:checked)").prop("disabled", true).end()
      .closest(".device-wrap").find("#device-continue").prop "disabled", false

      #disable tooltip
      $("#device-disabled-wrap").tooltip "destroy"
    else
      $devicesWrapper
      .find("input:disabled").prop("disabled", false).end()
      .closest(".device-wrap").find("#device-continue").prop "disabled", true

      #enable tooltip
      $("#device-disabled-wrap").tooltip()
    return

  getSelectedDevices: () ->
    checkedDevicesNames = _.pluck($("#device-list").find("input:checked"), 'name')

    return _.filter(@devices, (device) ->
      _.contains(checkedDevicesNames, device.name))