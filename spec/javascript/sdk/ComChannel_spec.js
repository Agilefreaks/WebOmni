define(['sdk/ComChannel', 'sdk/DataStore', 'jquery'], function (ComChannel, DataStore, $) {
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

    describe('open', function () {
      var endpoint;
      beforeEach(function() {
        endpoint = 'someEndpoint';
        DataStore.omnipasteUrl = 'http://some.url';
        DataStore.clientId = 'someId';
        subject = function() {
          instance.open(endpoint);
        }
      });

      it('opens an iframe in a modal pointing to the correct omnipaste url', function() {
        var $modalHtml = null;
        var spy = spyOn($, 'modal').andCallFake(function(html) {
          $modalHtml = $(html);
        });
        //the following is required as we call dispose in after each but in this case the entire modal is a spy
        spy.close = $.noop;

        subject();

        var iFrames = $modalHtml.find('iframe').add($modalHtml.filter('iframe'));
        expect(iFrames[0].src).toEqual('http://some.url/someId/someEndpoint');
      });

      it('sets the iframe in the modal on itself', function () {
        subject();

        expect(instance.iframe.tagName).toEqual('IFRAME');
      });
    });

    describe('dispose', function() {
      beforeEach(function() {
        subject = function() {
          instance.dispose();
        }
      });

      it('closes any modal opened by the SDK', function() {
        var spy = spyOn($.modal, 'close');

        subject();

        expect(spy).toHaveBeenCalled();
      });

      describe('receiving a valid window message event after the call', function () {
        var message;
        beforeEach(function () {
          message = {action: 'apiReady'};
          DataStore.omnipasteUrl = 'http://localhost:9876';
          subject = function () {
            instance.dispose();
            window.postMessage(JSON.stringify(message), '*');
          }
        });

        describe('the com channel has been previously opened', function () {
          beforeEach(function () {
            instance.open('someEndpoint');
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

    describe('receiving a window message event', function () {
      var message;
      beforeEach(function () {
        message = {action: 'apiReady'};
        subject = function () {
          window.postMessage(JSON.stringify(message), '*');
        }
      });

      describe('the com channel has been opened', function () {
        beforeEach(function () {
          instance.open('someEndpoint');
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
});