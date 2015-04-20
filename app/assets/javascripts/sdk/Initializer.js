define('sdk/Initializer', ['jquery'], function ($) {
  return {
    run: function (clientId) {
      $('[data-omnipaste-call]').click(function (event) {
        event.preventDefault();
        console.log('clicked link');

        return false;
      });
    }
  }
});