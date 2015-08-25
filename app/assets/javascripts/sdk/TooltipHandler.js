define('sdk/TooltipHandler', ['jquery', 'lodash', 'tooltip', 'i18n'], function ($, _, Tooltip, I18n) {
  var TooltipHandler = function() {
    this._tooltips = [];
  };

  _.extend(TooltipHandler.prototype, {
    initialize: function () {
      var self = this;
      $('[data-omnipaste-call]').each(function () {
        try {
          self._tooltips.push(new Tooltip({
            target: this,
            content: I18n.translate("js.sdk.click_tooltip"),
            classes: 'tooltip-tether-arrows',
            position: 'bottom middle'
          }));
        } catch(exception) {
          //do nothing as creating a tooltip on browsers older than IE9 doesn't work
        }
      });
    },

    dispose: function() {
      _.invoke(self._tooltips, 'destroy');
    }
  });

  return TooltipHandler;
});