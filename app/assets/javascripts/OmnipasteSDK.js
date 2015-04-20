//= require almond
//= require jquery.2.1.1
//= require_tree ./sdk
//= require_self

define('OmnipasteSDK', ['sdk/Initializer'], function(Initializer) {
  var OmnipasteSDK = function() {
    this.initializer = new Initializer();
  };

  OmnipasteSDK.prototype.initialize = function(clientId) {
    this.initializer.run(clientId);
  };

  return OmnipasteSDK;
});
