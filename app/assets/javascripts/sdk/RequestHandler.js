define('sdk/RequestHandler', [], function() {
  var RequestHandler = function() {
  };

  RequestHandler.prototype.handleCallRequest = function() {
    console.log('clicked a phone link');
  };

  return RequestHandler;
});