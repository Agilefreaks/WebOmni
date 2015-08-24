define('sdk/Initializer',
  ['jquery', 'lodash', './DataStore', './PhoneClickHandler'],
  function ($, _, DataStore, PhoneClickHandler) {
    var Initializer = function () {
      this.phoneClickHandler = new PhoneClickHandler();
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
      },

      dispose: function() {
        this.phoneClickHandler.dispose();
      }
    });

    return Initializer;
  });