define('sdk/RequestHandler', ['lodash', './DataStore', './helpers/Promise', './JSAPIClient', './RESTAPIClient'],
  function (_, DataStore, PromiseHelper, JSAPIClient, RESTAPIClient) {

    function getUserAccessToken() {
      var promise;
      if (_.isEmpty(DataStore.userAccessToken)) {
        promise = JSAPIClient.getInstance().getUserAccessToken().then(function(userAccessToken) {
          DataStore.userAccessToken = userAccessToken;
        });
      } else {
        promise = PromiseHelper.resolvedPromise(DataStore.userAccessToken);
      }

      return promise;
    }

    var RequestHandler = function () {
  };

  _.extend(RequestHandler.prototype, {
    handleCallRequest: function (requestData) {
      return getUserAccessToken().then(function() {
        return RESTAPIClient.getInstance().createPhoneCall(requestData);
      });
    }
  });

  return RequestHandler;
});