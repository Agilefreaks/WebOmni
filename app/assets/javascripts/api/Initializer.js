define('api/Initializer', ['lodash', './RequestHandler', './DataStore'], function (_, RequestHandler, DataStore) {
  var Initializer = function () {
    this.requestHandler = new RequestHandler();
  };

  function createMessageHandler(instance) {
    instance._messageHandler = _.bind(function (message) {
      instance.requestHandler.handle(message);
    }, instance);

    return instance._messageHandler;
  }

  function getClientWindow() {
    return window.opener || window.top;
  }

  _.extend(Initializer.prototype, {
    run: function (options) {
      _.extend(DataStore, _.pick(_.defaults({}, options), ['apiClientUrl', 'omnipasteUrl']));
      window.addEventListener("message", createMessageHandler(this), false);
      getClientWindow().postMessage(JSON.stringify({action: 'apiReady'}), DataStore.apiClientUrl);
    },

    dispose: function () {
      window.removeEventListener("message", this._messageHandler, false);
    }
  });

  return Initializer;
});
