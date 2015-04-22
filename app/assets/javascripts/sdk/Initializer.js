define('sdk/Initializer',
  ['jquery', 'lodash', './RequestHandler', './DataStore', './DisposableEventHandler'],
  function ($, _, RequestHandler, DataStore, DisposableEventHandler) {
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
        var handler = function (event) {
          self.requestHandler.handleCallRequest({
            phoneNumber: $(event.target).data('omnipasteCall')
          });
        };
        return new DisposableEventHandler($(document), 'click', '[data-omnipaste-call]', handler);
      } else {
        throw 'Invalid api key';
      }
    }
  });

  return Initializer;
});