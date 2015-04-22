define('sdk/ComChannel', ['lodash', 'EventEmitter', './DataStore'], function (_, EventEmitter, DataStore) {
  var ComChannel = function () {
    var self = this;

    function parseRequestOptions(messageData) {
      var options;
      try {
        options = JSON.parse(messageData)
      } catch (exception) {
      }

      return options;
    }

    function onMessageReceived(message) {
      if(message.origin === DataStore.omnipasteUrl) {
        var options = parseRequestOptions(message.data);
        if (options) {
          self.trigger(options.action, options.data);
        }
      }
    }

    window.addEventListener('message', onMessageReceived, false);

    this.dispose = function() {
      window.removeEventListener('message', onMessageReceived, false)
    }
  };

  _.extend(ComChannel.prototype, EventEmitter.prototype);

  return ComChannel;
});