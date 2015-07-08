define('api/Commands/GetUserAccessTokenCommand', ['lodash', './../DataStore'], function (_, DataStore) {
  var GetUserAccessTokenCommand = function (source) {
    this.source = source;
  };

  _.extend(GetUserAccessTokenCommand.prototype, {
    execute: function () {
      this.source.postMessage(JSON.stringify({
          action: 'setUserAccessToken',
          data: DataStore.userAccessToken
        }),
        DataStore.apiClientUrl);
    }
  });

  return GetUserAccessTokenCommand;
});