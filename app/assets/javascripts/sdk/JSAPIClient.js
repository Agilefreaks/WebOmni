define('sdk/JSAPIClient', ['lodash', 'jquery', './helpers/Promise', './ComChannel'],
  function (_, $, PromiseHelper, ComChannel) {
  var instance;

  var JSAPIClient = function () {
    var self = this;
    var initialized = false;
    var initializePending = null;

    function initializeCore(endpoint) {
      var initializeDeferred = $.Deferred();
      var promise = initializeDeferred.promise();
      self.comChannel = new ComChannel();
      self.comChannel.once('apiReady', initializeDeferred.resolve);
      self.comChannel.open(endpoint);
      return promise.then(function() {
        initializePending = null;
        initialized = true;
      });
    }

    this.initialize = function (endpoint) {
      var result;
      if(!initialized) {
        result = initializePending || (initializePending = initializeCore(endpoint));
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
      return this.initialize('userAccessToken');
    }
  });

  JSAPIClient.getInstance = function () {
    return instance || (instance = new JSAPIClient());
  };

  return JSAPIClient;
});