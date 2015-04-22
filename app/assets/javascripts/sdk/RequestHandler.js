define('sdk/RequestHandler', ['lodash', './DataStore', './JSAPIClient'], function (_, DataStore, JSAPIClient) {
  var RequestHandler = function () {
  };

  _.extend(RequestHandler.prototype, {
    handleCallRequest: function () {
      if (_.isEmpty(DataStore.userAccessToken)) {
        JSAPIClient.getInstance().getUserAccessToken().then(function(userAccessToken) {
          DataStore.userAccessToken = userAccessToken;
        });
      }
    }
  });

  return RequestHandler;
});