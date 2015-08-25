define('sdk/TooltipHandler', ['jquery', 'lodash', 'tooltip', 'i18n'], function ($, _, Tooltip, I18n) {
  var TooltipHandler = function() {
    this._tooltips = [];
    Tooltip.setClassPrefix('omnipaste-tooltip');
  };

  _.extend(TooltipHandler.prototype, {
    initialize: function () {
      var self = this;
      $('[data-omnipaste-call]').each(function () {
        var tooltip = new Tooltip({
          target: this,
          content: I18n.translate("js.sdk.click_tooltip"),
          classes: 'omnipaste-tooltip-theme-arrows',
          position: 'bottom center'
        });
        self._tooltips.push(tooltip);
      });
    },

    dispose: function() {
      _.invoke(self._tooltips, 'destroy');
    }
  });

  return TooltipHandler;
});