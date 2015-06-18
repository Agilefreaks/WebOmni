define('api/Commands/CommandFactory', ['lodash', './EmptyCommand', './GetUserAccessTokenCommand'],
  function (_, EmptyCommand, GetUserAccessTokenCommand) {
    var singletonInstance;

    function parseOptions(messageData) {
      var options;
      try {
        options = JSON.parse(messageData)
      } catch (exception) {
      }

      return options;
    }

    var CommandFactory = function () {
    };

    _.extend(CommandFactory.prototype, {
      create: function (message) {
        var options = parseOptions(message.data);
        var result;
        if (options) {
          switch (options.action) {
            case 'getUserAccessToken':
              result = new GetUserAccessTokenCommand(message.source);
              break;
            case 'showCallInProgress':
              break;
          }
        }

        if (result === undefined) {
          result = new EmptyCommand();
        }

        return result;
      }
    });

    CommandFactory.getInstance = function () {
      return singletonInstance || (singletonInstance = new CommandFactory());
    };

    return CommandFactory;
  });