define('sdk/Initializer', ['jquery', 'lodash', './RequestHandler', './DataStore'], function ($, _, RequestHandler, DataStore) {
  var Initializer = function () {
    this.requestHandler = new RequestHandler();
  };

  function clientIdIsValid(clientId) {
    return _.isString(clientId) && !_.isEmpty(clientId);
  }

  _.extend(Initializer.prototype, {
    run: function (clientId) {
      var self = this;
      if(clientIdIsValid(clientId)) {
        DataStore.clientId = clientId;
        $(document).on('click', '[data-omnipaste-call]', function () {
          self.requestHandler.handleCallRequest({
            phoneNumber: $(this).data('omnipasteCall')
          });
        });
      } else {
        throw 'Invalid api key';
      }
    }
  });

  return Initializer;
});