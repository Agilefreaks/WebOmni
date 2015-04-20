define('sdk/Initializer', ['jquery', 'sdk/RequestHandler'], function ($, RequestHandler) {
  var Initializer = function () {
    this.requestHandler = new RequestHandler();
  };

  Initializer.prototype.run = function (clientId) {
    var self = this;

    $(document).on('click', '[data-omnipaste-call]', function () {
      self.requestHandler.handleCallRequest({
        clientId: clientId,
        phoneNumber: $(this).data('omnipasteCall')
      });
    });
  };

  return Initializer;
});