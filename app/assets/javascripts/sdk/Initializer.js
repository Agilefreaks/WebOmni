define('sdk/Initializer', ['jquery', 'lodash', 'sdk/RequestHandler'], function ($, _, RequestHandler) {
  var Initializer = function () {
    this.requestHandler = new RequestHandler();
  };

  _.extend(Initializer.prototype, {
    run: function (clientId) {
      var self = this;

      $(document).on('click', '[data-omnipaste-call]', function () {
        self.requestHandler.handleCallRequest({
          clientId: clientId,
          phoneNumber: $(this).data('omnipasteCall')
        });
      });
    }
  });

  return Initializer;
});