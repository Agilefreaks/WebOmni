define('sdk/ComChannel', ['lodash', 'jquery', 'EventEmitter', './DataStore'],
  function (_, $, EventEmitter, DataStore) {
    var API_READY_MESSAGE = 'apiReady';
    var CHANNEL_CLOSED = 'channelClosed';

    function parseRequestOptions(messageData) {
      var options;
      try {
        options = JSON.parse(messageData)
      } catch (exception) {
      }

      return options;
    }

    function handleMessage(instance, message) {
      if (message.origin === DataStore.omnipasteUrl) {
        var options = parseRequestOptions(message.data);
        if (options) {
          instance.trigger(options.action, [options.data]);
        }
      }
    }

    function createComWindow(endpoint, width, height, name) {
      var url = DataStore.omnipasteUrl + '/api/' + DataStore.clientId + '/' + endpoint;
      var left = (screen.width/2)-(width/2);
      var top = (screen.height/2)-(height/2);
      return window.open(url, name, "menubar=no,toolbar=no,status=no,width="+width+",height="+height+",toolbar=no,left="+left+",top="+top, false);
    }

    function setupCloseWindowWatchdog(instance, targetWindow) {
      instance._pollTimer = setInterval(function () {
        if (targetWindow.closed !== false) {
          instance.dispose();
        }
      }, 200);
    }

    function setupIncomingMessageHandler(instance) {
      instance._messageHandler = _.partial(handleMessage, instance);
      window.addEventListener('message', instance._messageHandler, false);
    }

    var ComChannel = function () {
    };

    _.extend(ComChannel.prototype, EventEmitter.prototype);

    _.extend(ComChannel.prototype, {
      open: function (endpoint) {
        var self = this;
        var deferred = $.Deferred();
        setupIncomingMessageHandler(self);
        self.once(API_READY_MESSAGE, deferred.resolve);
        self.once(CHANNEL_CLOSED, deferred.reject);
        var targetWindow = createComWindow(endpoint, 600, 400, "Authenticating");
        if(targetWindow) {
          setupCloseWindowWatchdog(self, targetWindow);
          this.targetWindow = targetWindow;
        } else {
          self.off(API_READY_MESSAGE, deferred.resolve);
          self.off(CHANNEL_CLOSED, deferred.resolve);
          self.dispose();
          deferred.reject('Could not open window to Omnipaste');
        }

        return deferred.promise();
      },

      dispose: function () {
        //we probably need to also remove references to all pending listeners
        clearInterval(this._pollTimer);
        window.removeEventListener('message', this._messageHandler, false);
        this.targetWindow && this.targetWindow.close();
        this.trigger(CHANNEL_CLOSED);
      },

      send: function (message) {
        this.targetWindow.postMessage(JSON.stringify(message), DataStore.omnipasteUrl);
      }
    });

    ComChannel.create = function() {
      return new ComChannel();
    };

    return ComChannel;
  });