define('sdk/Initializer',
  ['jquery', 'lodash', './DataStore', './PhoneClickHandler', './TooltipHandler'],
  function ($, _, DataStore, PhoneClickHandler, TooltipHandler) {
    function insertCSS(code) {
      var style = document.createElement('style');
      style.type = 'text/css';
      if (style.styleSheet) {
        // IE
        style.styleSheet.cssText = code;
      } else {
        // Other browsers
        style.innerHTML = code;
      }

      document.getElementsByTagName("head")[0].appendChild(style);
    }

    var Initializer = function () {
      this.phoneClickHandler = new PhoneClickHandler();
      this.tooltipHandler = new TooltipHandler();
    };

    function clientIdIsValid(clientId) {
      return _.isString(clientId) && !_.isEmpty(clientId);
    }

    _.extend(Initializer.prototype, {
      run: function (options) {
        options = _.defaults({}, options);
        if (!clientIdIsValid(options.clientId)) throw 'Invalid api key';
        _.extend(DataStore, _.pick(options, ['clientId', 'omnipasteUrl', 'omnipasteAPIUrl']));
        insertCSS(options.styles);
        this.phoneClickHandler.initialize();
        this.tooltipHandler.initialize();
      },

      dispose: function() {
        this.phoneClickHandler.dispose();
        this.tooltipHandler.dispose();
      }
    });

    return Initializer;
  });