define('sdk/ComChannel', ['lodash', 'jquery', 'EventEmitter', './DataStore', './helpers/Promise'],
  function (_, $, EventEmitter, DataStore, PromiseHelper) {

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
        setupIncomingMessageHandler(self);
        var targetWindow = createComWindow(endpoint, 600, 400, "Authenticating");
        var result;
        if(targetWindow) {
          setupCloseWindowWatchdog(self, targetWindow);
          this.targetWindow = targetWindow;
          result = PromiseHelper.resolvedPromise(self);
        } else {
          self.dispose();
          result = PromiseHelper.rejectedPromise('Could not open window to Omnipaste');
        }

        return result;
      },

      dispose: function () {
        //we probably need to also remove references to all pending listeners
        clearInterval(this._pollTimer);
        window.removeEventListener('message', this._messageHandler, false);
        this.targetWindow && this.targetWindow.close();
        this.trigger('channelClosed');
      },

      send: function (message) {
        this.targetWindow.postMessage(JSON.stringify(message), DataStore.omnipasteUrl);
      }
    });

    return ComChannel;
  });