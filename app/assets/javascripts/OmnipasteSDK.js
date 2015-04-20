//= require almond
//= require jquery.2.1.1
//= require_tree ./sdk
//= require_self

define('OmnipasteSDK', ['sdk/Initializer'], function(Initializer) {
  return {
    initialize: function(clientId) {
      Initializer.run(clientId);
    }
  }
});
