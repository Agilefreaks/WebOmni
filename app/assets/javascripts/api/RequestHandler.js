define('api/RequestHandler', [], function() {
  var RequestHandler = function() {
  };

  RequestHandler.prototype.handle = function() {
    console.log('received a new request');
  };

  return RequestHandler;
});