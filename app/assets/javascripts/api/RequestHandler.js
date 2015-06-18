define('api/RequestHandler', ['lodash', './DataStore', './Commands/CommandFactory'], function (_, DataStore, CommandFactory) {
  var RequestHandler = function () {
  };

  _.extend(RequestHandler.prototype, {
    isAuthorized: function (message) {
      return message.origin == DataStore.apiClientUrl;
    },

    handle: function (message) {
      if (this.isAuthorized(message)) {
        CommandFactory.getInstance().create(message).execute();
      }
    }
  });

  return RequestHandler;
});