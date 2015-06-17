define('sdk/JSAPIClient', ['lodash', 'jquery', './helpers/Promise', './ComChannel'], function (_, $, PromiseHelper, ComChannel) {
  var instance;
  var initializeEndpoint = 'prepare_for_phone_usage';

  var JSAPIClient = function () {
    var self = this;
    var initialized = false;
    var initializePending = null;

    function initializeCore() {
      self.comChannel = new ComChannel();
      return self.comChannel.open(initializeEndpoint)
        .then(function () {
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
    waitForResponse: function(responseName) {
      var self = this;
      var deferred = $.Deferred();
      self.comChannel.once('channelClosed', deferred.reject);
      self.comChannel.once(responseName, deferred.resolve);

      return deferred.promise()
        .fail(_.bind(self.reset, self))
        .always(function () {
          self.comChannel.off('channelClosed', deferred.reject);
          self.comChannel.off(responseName, deferred.resolve);
        });
    },

    makeRequest: function (actionName, responseName) {
      var promise = this.waitForResponse(responseName);
      if(actionName) {
        this.comChannel.send({action: actionName});
      }

      return promise;
    },

    prepareForPhoneUsage: function () {
      var self = this;
      return self.initialize().then(function () {
        return self.makeRequest('getUserAccessToken', 'setUserAccessToken')
      });
    },

    showCallInProgress: function() {
      return PromiseHelper.resolvedPromise();
    }
  });

  JSAPIClient.getInstance = function () {
    return instance || (instance = new JSAPIClient());
  };

  return JSAPIClient;
});
