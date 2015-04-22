define('sdk/RequestHandler', ['lodash'], function(_) {
  var RequestHandler = function() {
  };

  _.extend(RequestHandler.prototype, {
    handleCallRequest: function() {
      console.log('clicked a phone link');
    }
  });

  return RequestHandler;
});