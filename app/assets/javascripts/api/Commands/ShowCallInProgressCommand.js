define('api/Commands/ShowCallInProgressCommand', ['lodash', './../DataStore'], function (_, DataStore) {
  var ShowCallInProgressCommand = function (router) {
    if(!router) {
      throw 'ShowCallInProgressCommand requires a router';
    }

    this.router = router;
  };

  _.extend(ShowCallInProgressCommand.prototype, {
    execute: function () {
      this.router.navigate('/api/' + DataStore.clientId + '/call_in_progress' + '?locale=' + DataStore.clientLocale);
    }
  });

  return ShowCallInProgressCommand;
});