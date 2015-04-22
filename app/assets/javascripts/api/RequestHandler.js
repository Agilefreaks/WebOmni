define('api/RequestHandler', ['lodash', './DataStore'], function (_, DataStore) {
  var RequestHandler = function () {
  };

  function parseRequestOptions(messageData) {
    var options;
    try {
      options = JSON.parse(messageData)
    } catch (exception) {
    }

    return options;
  }

  _.extend(RequestHandler.prototype, {
    isAuthorized: function (message) {
      return message.origin == DataStore.apiClientUrl;
    },

    handle: function (message) {
      if (this.isAuthorized(message)) {
        var requestOptions = parseRequestOptions(message.data);
        if (requestOptions) {
          switch (requestOptions.action) {
            case 'getUserAccessToken':
              message.source.postMessage(JSON.stringify({action: 'setUserAccessToken', data: DataStore.userAccessToken}), DataStore.omnipasteUrl);
              break;
          }
        }
      }
    }
  });

  return RequestHandler;
});