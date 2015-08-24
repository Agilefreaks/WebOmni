define('sdk/PhoneClickHandler', ['jquery', 'lodash', './RequestHandler', './DisposableEventHandler'],
  function ($, _, RequestHandler, DisposableEventHandler) {
    var PhoneClickHandler = function () {
      this.requestHandler = new RequestHandler();
    };

    _.extend(PhoneClickHandler.prototype, {
      handle: function (event) {
        this.requestHandler.handleCallRequest({phoneNumber: $(event.target).data('omnipasteCall')});
      },

      initialize: function () {
        this.dispose();
        var handler = _.bind(this.handle, this);
        this._disposableHandler = new DisposableEventHandler($(document), 'click', '[data-omnipaste-call]', handler);
      },

      dispose: function () {
        if (!this._disposableHandler) return;
        this._disposableHandler.dispose();
        delete this._disposableHandler;
      }
    });

    return PhoneClickHandler;
  });