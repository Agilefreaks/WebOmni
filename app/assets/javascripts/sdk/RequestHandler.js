define('sdk/RequestHandler', ['lodash', './DataStore', './helpers/Promise', './JSAPIClient', './RESTAPIClient'],
  function (_, DataStore, PromiseHelper, JSAPIClient, RESTAPIClient) {

    function getUserAccessToken() {
      var promise;
      if (_.isEmpty(DataStore.userAccessToken)) {
        promise = JSAPIClient.getInstance().prepareForPhoneUsage().then(function(userAccessToken) {
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
      var jsAPIClient = JSAPIClient.getInstance();
      var restAPIClient = RESTAPIClient.getInstance();
      var phoneCallData = {
        number: requestData.phoneNumber,
        type: 'outgoing',
        state: 'starting'
      };
      return getUserAccessToken()
        .then(_.bind(jsAPIClient.showCallInProgress, jsAPIClient))
        .then(_.bind(restAPIClient.createPhoneCall, restAPIClient, phoneCallData));
    }
  });

  return RequestHandler;
});