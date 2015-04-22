define(['api/Initializer', 'api/RequestHandler', 'api/DataStore'], function (Initializer, RequestHandler, DataStore) {
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

    describe('run', function() {
      var apiClientUrl;

      beforeEach(function() {
        apiClientUrl = 'http://some.url';
        subject = function() {
          instance.run(apiClientUrl);
        }
      });

      it('sets the apiClientUrl in the DataStore to the same value as the given one', function() {
        subject();

        expect(DataStore.apiClientUrl).toEqual(apiClientUrl);
      });

      it('sends an apiReady message to the top window with the apiClientUrl as the targetOrigin', function() {
        var spy = spyOn(window.top, 'postMessage');

        subject();

        expect(spy).toHaveBeenCalledWith(JSON.stringify({action: 'apiReady'}), apiClientUrl);
      });
    });

    describe('posting a message to the window', function () {
      beforeEach(function () {
        subject = function () {
          window.postMessage('SomeMessageHere', '*');
        }
      });

      describe('after calling run', function () {
        beforeEach(function () {
          instance.run('http://some.url');
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