define('sdk/Initializer',
  ['jquery', 'lodash', './DataStore', './PhoneClickHandler', './TooltipHandler'],
  function ($, _, DataStore, PhoneClickHandler, TooltipHandler) {
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