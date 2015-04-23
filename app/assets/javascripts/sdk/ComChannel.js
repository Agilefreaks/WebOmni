define('sdk/ComChannel', ['lodash', 'jquery', 'EventEmitter', 'SimpleModal', './DataStore'],
  function (_, $, EventEmitter, SimpleModal, DataStore) {

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

    var ComChannel = function () {
    };

    _.extend(ComChannel.prototype, EventEmitter.prototype);

    _.extend(ComChannel.prototype, {
      open: function (endpoint) {
        var self = this;
        this._messageHandler = _.partial(handleMessage, this);
        window.addEventListener('message', this._messageHandler, false);

        var url = DataStore.omnipasteUrl + '/' + DataStore.clientId + '/' + endpoint;
        var modal = $.modal('<iframe src="' + url + '" height="450" width="450" style="border:0">', {
          closeHTML: "<span>X</span>",
          containerCss: {
            backgroundColor: "#fff",
            borderColor: "#fff",
            height: 450,
            padding: 0,
            width: 450
          },
          overlayClose: true,
          focus: false,
          onClose: function() {
            $.modal.close(); // this is required by SimplePopover when using the onClose callback
            self.trigger('channelClosed');
          }
        });

        if (modal) {
          this.iframe = modal.d.data.find('iframe')[0];
        }
      },

      dispose: function () {
        //we probably need to also remove references to all pending listeners
        window.removeEventListener('message', this._messageHandler, false);
        $.modal.close();
      },

      send: function (message) {
        this.iframe.contentWindow.postMessage(JSON.stringify(message), DataStore.omnipasteUrl);
      }
    });

    return ComChannel;
  });