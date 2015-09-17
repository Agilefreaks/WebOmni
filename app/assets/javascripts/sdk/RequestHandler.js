define('sdk/RequestHandler', ['lodash', './DataStore', './helpers/Promise', './JSAPIClient', './RESTAPIClient'],
  function (_, DataStore, PromiseHelper, JSAPIClient, RESTAPIClient) {

    function getUserAccessToken() {
      var promise;
      if (_.isEmpty(DataStore.userAccessToken)) {
        promise = JSAPIClient.getInstance().prepareForPhoneUsage().then(function(response) {
          DataStore.userAccessToken = response.accessToken;
          DataStore.userRefreshToken = response.refreshToken;
        });
      } else {
        promise = PromiseHelper.resolvedPromise(DataStore.userAccessToken);
      }

      return promise;
    }

    function handleExpiredToken(onTokenRefreshed, response) {
      var restAPIClient = RESTAPIClient.getInstance();
      return response.status === 401
        ? restAPIClient.refreshToken().then(onTokenRefreshed)
        : PromiseHelper.rejectedPromise();
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

      var showCallInProgress = _.bind(jsAPIClient.showCallInProgress, jsAPIClient);
      var createPhoneCall = _.partial(restAPIClient.createPhoneCall, phoneCallData);
      var onError = _.partial(handleExpiredToken, createPhoneCall);
      return getUserAccessToken()
        .then(showCallInProgress)
        .then(function () {
          return createPhoneCall().then(PromiseHelper.resolvedPromise, onError);
        });
    }
  });

  return RequestHandler;
});