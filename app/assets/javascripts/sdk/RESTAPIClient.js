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
    },

    refreshToken: function() {
      return $.ajax({
        url: DataStore.omnipasteAPIUrl + '/oauth2/token',
        method: 'POST',
        dataType: 'JSON',
        data: {
          client_id: DataStore.clientId,
          grant_type: 'refresh_token',
          refresh_token: DataStore.userRefreshToken,
          resource_type: 'user_client_association'
        }
      });
    }
  });

  RESTAPIClient.getInstance = function () {
    return instance || (instance = new RESTAPIClient());
  };

  return RESTAPIClient;
});