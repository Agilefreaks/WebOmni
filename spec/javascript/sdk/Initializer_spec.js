define(['sdk/Initializer', 'sdk/RequestHandler', 'jquery', 'lodash'], function (Initializer, RequestHandler, $, _) {
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
      var clientId;
      beforeEach(function() {
        subject = function() {
          instance.run(clientId);
        }
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

        it('throws an exception', function() {
          expect(subject).not.toThrow('Invalid api key');
        });
      });
    });

    describe('events', function () {
      var clientId;
      describe('after run', function () {
        clientId = 'someId';

        beforeEach(function () {
          instance.run(clientId);
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
              var spy = spyOn(instance.requestHandler, 'handleCallRequest');

              subject();

              expect(spy).toHaveBeenCalledWith({phoneNumber: '0000111222'});
            });
          });
        });
      });
    });
  });
});