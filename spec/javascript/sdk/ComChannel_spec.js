define(['sdk/ComChannel', 'sdk/DataStore'], function (ComChannel, DataStore) {
  describe('ComChannel', function () {
    var instance, subject;

    beforeEach(function () {
      instance = new ComChannel();
      subject = function () {
        return instance;
      }
    });

    afterEach(function () {
      instance.dispose();
    });

    describe('receiving a window message event', function () {
      var message;
      beforeEach(function () {
        message = {action: 'apiReady'};
        subject = function () {
          window.postMessage(JSON.stringify(message), '*');
        }
      });

      describe('the message origin matches the omnipaste url', function () {
        beforeEach(function () {
          DataStore.omnipasteUrl = 'http://localhost:9876';
        });

        it('triggers an event with the action name contained in the message', function () {
          var wasTriggered;
          instance.on('apiReady', function () {
            wasTriggered = true;
          });

          subject();

          waitsFor(function () {
            return wasTriggered;
          }, 'the event to be triggered', 500);
        });
      });

      describe('the message origin does not match the omnipaste url', function () {
        beforeEach(function () {
          DataStore.omnipasteUrl = 'http://someUrl';
        });

        it('does not trigger an event with the action name contained in the message', function () {
          var wasTriggered = false;
          instance.on('apiReady', function () {
            wasTriggered = true;
          });

          var timeElapsed;
          setTimeout(function () {
            timeElapsed = true;
          }, 500);

          subject();

          waitsFor(function () {
            return timeElapsed;
          }, 'the event to be triggered', 700);

          runs(function () {
            expect(wasTriggered).toBe(false);
          });
        });
      });
    });
  });
});