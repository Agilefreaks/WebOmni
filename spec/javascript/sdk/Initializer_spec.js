define(['sdk/Initializer', 'sdk/RequestHandler', 'jquery', 'lodash', 'sdk/DataStore'],
  function (Initializer, RequestHandler, $, _, DataStore) {
  describe('Initializer', function () {
    var subject, instance;

    beforeEach(function () {
      instance = new Initializer();
      subject = function () {
        return instance;
      };
    });

    it('has a run function', function () {
      expect(subject().run).not.toBeUndefined(true);
    });

    it('has a request handler', function () {
      expect(subject().requestHandler instanceof RequestHandler).toBe(true);
    });

    describe('run', function () {
      var clientId, omnipasteUrl, omnipasteAPIUrl, listener;
      beforeEach(function() {
        omnipasteUrl = 'http://some.url';
        omnipasteAPIUrl = 'http://someOther.url';
        subject = function() {
          listener = instance.run({clientId: clientId, omnipasteUrl: omnipasteUrl, omnipasteAPIUrl: omnipasteAPIUrl});
        }
      });

      afterEach(function() {
        listener && listener.dispose();
      });

      _.each([null, undefined, false, '', {someProp: 'asa'}, 4], function(value) {
        describe('the given client id is ' + value, function () {
          beforeEach(function() {
            clientId = value;
          });

          it('throws an exception', function() {
            expect(subject).toThrow('Invalid api key');
          });
        });
      });

      describe('the given client id is a non empty string', function () {
        beforeEach(function() {
          clientId = 'testKey';
        });

        it('does not throw an exception', function() {
          expect(subject).not.toThrow('Invalid api key');
        });

        it('stores the given client id', function() {
          expect(DataStore.clientId).toEqual(clientId);
        });

        it('stores the give omnipasteUrl', function() {
          expect(DataStore.omnipasteUrl).toEqual(omnipasteUrl);
        });

        it('stores the give omnipasteAPIUrl', function() {
          expect(DataStore.omnipasteAPIUrl).toEqual(omnipasteAPIUrl);
        });
      });
    });

    describe('events', function () {
      var clientId, listener;

      describe('after run', function () {
        clientId = 'someId';

        beforeEach(function () {
          listener = instance.run({clientId: clientId});
        });

        afterEach(function() {
          listener && listener.dispose();
        });

        describe('an html element exists in the dom with the data-omnipaste-call attribute', function () {
          var htmlElement;
          beforeEach(function () {
            htmlElement = $('<div data-omnipaste-call="0000111222"></div>').appendTo($('body'));
          });

          afterEach(function () {
            htmlElement.remove();
          });

          describe('clicking the element', function () {
            beforeEach(function () {
              subject = function () {
                htmlElement.click();
              }
            });

            it('calls handleCallRequest on the request handler with the client if and the phone number', function () {
              var spy = spyOn(instance.requestHandler, 'handleCallRequest').andReturn(void 0);

              subject();

              expect(spy).toHaveBeenCalledWith({phoneNumber: '0000111222'});
            });
          });
        });
      });
    });
  });
});