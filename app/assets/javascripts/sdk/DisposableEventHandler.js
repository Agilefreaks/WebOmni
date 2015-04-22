define('sdk/DisposableEventHandler', function () {
  var DisposableEventHandler = function ($target, event, selector, handler) {
    $target.on(event, selector, handler);

    this.dispose = function () {
      $target.off(event, selector, handler);
    }
  };

  return DisposableEventHandler;
});