//= require almond
//= require jquery.2.1.1
//= require lodash
//= require eventEmitter
//= require_tree ./sdk
//= require_self

define('OmnipasteSDK', ['sdk/Initializer', 'jquery', 'lodash'], function (Initializer, jQuery, _) {
  jQuery.noConflict(true);

  var OmnipasteSDK = function () {
    this.initializer = new Initializer();
  };

  _.extend(OmnipasteSDK.prototype, {
    initialize: function (options) {
      this.initializer.run(options);
    }
  });

  return OmnipasteSDK;
});
