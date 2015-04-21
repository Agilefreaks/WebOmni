define(['api/Initializer', 'api/RequestHandler'], function (Initializer, RequestHandler) {
  describe('api/Initializer', function () {
    var instance, subject;

    beforeEach(function () {
      instance = new Initializer();
      subject = function () {
        return instance;
      }
    });

    it('has a run method', function () {
      expect(subject().run).toBeDefined();
    });

    it('has a request handler', function() {
      expect(subject().requestHandler instanceof RequestHandler).toBe(true);
    });

    describe('posting a message to the window', function () {
      beforeEach(function () {
        subject = function () {
          window.postMessage('SomeMessageHere', '*');
        }
      });

      describe('after calling run', function () {
        beforeEach(function () {
          instance.run();
        });

        afterEach(function () {
          instance.dispose();
        });

        it('passes the message to the requestHandler', function () {
          var spy = spyOn(instance.requestHandler, 'handle');

          subject();

          waitsFor(function() {
            return spy.calls.length > 0;
          }, 'onMessageReceived to be called', 1000);
        });
      });
    });
  });
});