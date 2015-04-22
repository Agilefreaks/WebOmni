//= require almond
//= require jquery.2.1.1
//= require lodash
//= require_tree ./sdk
//= require_self

define('OmnipasteSDK', ['sdk/Initializer', 'jquery', 'lodash'], function (Initializer, jQuery, _) {
  jQuery.noConflict(true);

  var OmnipasteSDK = function () {
    this.initializer = new Initializer();
  };

  _.extend(OmnipasteSDK.prototype, {
    initialize: function (clientId) {
      this.initializer.run(clientId);
    }
  });

  return OmnipasteSDK;
});
