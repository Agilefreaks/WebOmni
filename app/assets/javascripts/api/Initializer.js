define('api/Initializer', ['lodash', './RequestHandler'], function (_, RequestHandler) {
  var Initializer = function () {
    this.requestHandler = new RequestHandler();
  };

  function createMessageHandler(instance) {
    instance._messageHandler = _.bind(function (message) {
      instance.requestHandler.handle(message);
    }, instance);

    return instance._messageHandler;
  }

  _.extend(Initializer.prototype, {
    run: function () {
      window.addEventListener("message", createMessageHandler(this), false);
    },

    dispose: function () {
      window.removeEventListener("message", this._messageHandler, false);
    }
  });

  return Initializer;
});
