define('sdk/JSAPIClient', ['lodash', 'jquery', './helpers/Promise', './ComChannel'], function (_, $, PromiseHelper, ComChannel) {
  var singletonInstance;
  var INITIALIZE_ENDPOINT = 'prepare_for_phone_usage';
  var COM_CHANNEL_CLOSED = 'channelClosed';

  var JSAPIClient = function () {
    var self = this;
    var comChannel = ComChannel.create();
    var comChannelInitialized = false;
    var comChannelInitializePending = null;

    function initializeComChannel() {
      return comChannel.open(INITIALIZE_ENDPOINT)
        .then(function () {
          comChannel.once(COM_CHANNEL_CLOSED, self.reset);
          comChannelInitializePending = null;
          comChannelInitialized = true;
          return PromiseHelper.resolvedPromise();
        });
    }

    function waitForResponse(responseName) {
      return self.initialize().then(function () {
        var deferred = $.Deferred();
        comChannel.once(COM_CHANNEL_CLOSED, deferred.reject);
        comChannel.once(responseName, deferred.resolve);
        return deferred.promise().always(function () {
          comChannel.off(COM_CHANNEL_CLOSED, deferred.reject);
          comChannel.off(responseName, deferred.resolve);
        });
      });
    }

    function sendMessage(actionName) {
      return self.initialize().then(function() {
        comChannel.send({action: actionName});
        return PromiseHelper.resolvedPromise();
      });
    }

    function makeRequest(actionName, responseName) {
      var responsePromise = waitForResponse(responseName);
      return sendMessage(actionName).then(function() {
        return responsePromise;
      });
    }

    this.initialize = function () {
      var result;
      if(!comChannelInitialized) {
        result = comChannelInitializePending || (comChannelInitializePending = initializeComChannel());
      } else {
        result = PromiseHelper.resolvedPromise();
      }

      return result;
    };

    this.reset = function() {
      comChannel.dispose();
      comChannelInitializePending = null;
      comChannelInitialized = false;
    };

    this.prepareForPhoneUsage = function () {
      return makeRequest('getUserAccessToken', 'setUserAccessToken');
    };

    this.showCallInProgress = function() {
      return sendMessage('showCallInProgress');
    }
  };

  JSAPIClient.getInstance = function () {
    return singletonInstance || (singletonInstance = new JSAPIClient());
  };

  return JSAPIClient;
});