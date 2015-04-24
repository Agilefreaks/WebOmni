define('sdk/RESTAPIClient', ['lodash'], function (_) {
  var instance;

  var RESTAPIClient = function () {
  };

  _.extend(RESTAPIClient.prototype, {
    createPhoneCall: function () {
    }
  });

  RESTAPIClient.getInstance = function () {
    return instance || (instance = new RESTAPIClient());
  };

  return RESTAPIClient;
});