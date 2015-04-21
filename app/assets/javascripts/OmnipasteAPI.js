//= require almond
//= require lodash
//= require_tree ./api
//= require_self

define('OmnipasteAPI', ['lodash', 'api/Initializer'], function(_, Initializer) {
  var OmnipasteAPI = function () {
    this.initializer = new Initializer();
  };

  _.extend(OmnipasteAPI.prototype, {
    initialize: function (apiClientUrl) {
      this.initializer.run(apiClientUrl);
    }
  });

  return OmnipasteAPI;
});