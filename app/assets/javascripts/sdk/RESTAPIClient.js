define('sdk/RESTAPIClient', ['lodash', 'jquery', './DataStore'], function (_, $, DataStore) {
  var instance;

  var RESTAPIClient = function () {
  };

  _.extend(RESTAPIClient.prototype, {
    createPhoneCall: function (phoneCall) {
      return $.ajax({
        url: DataStore.omnipasteAPIUrl + '/phone_calls',
        method: 'POST',
        headers: {'Authorization': 'Bearer ' + DataStore.userAccessToken},
        dataType: 'JSON',
        data: phoneCall
      });
    }
  });

  RESTAPIClient.getInstance = function () {
    return instance || (instance = new RESTAPIClient());
  };

  return RESTAPIClient;
});