define('api/Commands/EmptyCommand', ['lodash'], function (_) {
  var EmptyCommand = function () {
  };

  _.extend(EmptyCommand.prototype, {
    execute: function () {
    }
  });

  return EmptyCommand;
});