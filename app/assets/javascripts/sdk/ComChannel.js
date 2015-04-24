define('sdk/ComChannel', ['lodash', 'jquery', 'EventEmitter', './DataStore'],
  function (_, $, EventEmitter, DataStore) {

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

    function createComWindow(url, width, height, name) {
      var left = (screen.width/2)-(width/2);
      var top = (screen.height/2)-(height/2);
      return window.open(url, name, "menubar=no,toolbar=no,status=no,width="+width+",height="+height+",toolbar=no,left="+left+",top="+top, false);
    }

    var ComChannel = function () {
    };

    _.extend(ComChannel.prototype, EventEmitter.prototype);

    _.extend(ComChannel.prototype, {
      open: function (endpoint) {
        var self = this;
        this._messageHandler = _.partial(handleMessage, this);
        window.addEventListener('message', this._messageHandler, false);
        var url = DataStore.omnipasteUrl + '/api/' + DataStore.clientId + '/' + endpoint;
        var targetWindow = createComWindow(url, 600, 400, "authWindow");
        var pollTimer = setInterval(function() {
          if (targetWindow.closed !== false) {
            clearInterval(pollTimer);
            self.trigger('channelClosed')
          }
        }, 200);
        if (targetWindow) {
          this.targetWindow = targetWindow;
        }
      },

      dispose: function () {
        //we probably need to also remove references to all pending listeners
        window.removeEventListener('message', this._messageHandler, false);
        this.targetWindow && this.targetWindow.close();
      },

      send: function (message) {
        this.targetWindow.postMessage(JSON.stringify(message), DataStore.omnipasteUrl);
      }
    });

    return ComChannel;
  });