define('sdk/JSAPIClient', ['lodash', 'jquery', 'sdk/helpers/Promise', 'sdk/ComChannel'],
  function (_, $, PromiseHelper, ComChannel) {
  var instance;

  var JSAPIClient = function () {
    var self = this;
    var initialized = false;
    var initializePending = null;

    function initializeCore() {
      var initializeDeferred = $.Deferred();
      var promise = initializeDeferred.promise();
      self.comChannel = new ComChannel();
      self.comChannel.once('apiReady', initializeDeferred.resolve);
      return promise.then(function() {
        initializePending = null;
        initialized = true;
      });
    }

    this.initialize = function () {
      var result;
      if(!initialized) {
        result = initializePending || (initializePending = initializeCore());
      } else {
        result = PromiseHelper.resolvedPromise();
      }

      return result;
    };

    this.reset = function() {
      this.comChannel && this.comChannel.dispose();
      initializePending = null;
      initialized = false;
    };
  };

  _.extend(JSAPIClient.prototype, {
    getUserAccessToken: function () {
      return this.initialize();
    }
  });

  JSAPIClient.getInstance = function () {
    return instance || (instance = new JSAPIClient());
  };

  return JSAPIClient;
});