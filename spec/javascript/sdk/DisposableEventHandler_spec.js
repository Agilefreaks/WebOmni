define(['sdk/DisposableEventHandler', 'jquery'], function (DisposableEventHandler, $) {
  var $target, eventName, selector, handler, instance, subject;

  describe('DisposableEventHandler', function () {
    beforeEach(function () {
      $target = $('<div id="someDiv"><span id="someSpan"></span><span id="someOtherSpan"></span></div>');
      eventName = 'click';
      selector = 'span';
      handler = jasmine.createSpy('clickHandler');
      instance = new DisposableEventHandler($target, eventName, selector, handler);
      subject = function () {
        return instance;
      }
    });

    it('has a dispose method', function () {
      expect(subject().dispose).toBeDefined();
    });

    describe('triggering the event on the target', function () {
      beforeEach(function () {
        subject = function() {
          $target.find('#someSpan').click();
        }
      });

      it('calls the handler', function () {
        subject();

        expect(handler).toHaveBeenCalled();
      });
    });

    describe('dispose', function () {
      beforeEach(function () {
        subject = function () {
          instance.dispose();
        }
      });

      it('triggering the event no longer calls the handler', function () {
        subject();
        $target.find('#someSpan').click();

        expect(handler).not.toHaveBeenCalled();
      });
    });
  });
});