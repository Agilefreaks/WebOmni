define('api/Commands/GetUserAccessTokenCommand', ['lodash', './../DataStore'], function (_, DataStore) {
  var GetUserAccessTokenCommand = function (source) {
    this.source = source;
  };

  _.extend(GetUserAccessTokenCommand.prototype, {
    execute: function () {
      this.source.postMessage(JSON.stringify({
          action: 'setUserAccessToken',
          data: {accessToken: DataStore.userAccessToken, refreshToken: DataStore.userRefreshToken}
        }),
        DataStore.apiClientUrl);
    }
  });

  return GetUserAccessTokenCommand;
});