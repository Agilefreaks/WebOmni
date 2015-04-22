define(['api/RequestHandler', 'api/DataStore'], function (RequestHandler, DataStore) {
  describe('api/RequestHandler', function () {
    var instance, subject;
    beforeEach(function () {
      instance = new RequestHandler();
      subject = function () {
        return instance;
      }
    });

    describe('isAuthorized', function () {
      var message;

      beforeEach(function () {
        message = {};

        subject = function () {
          return instance.isAuthorized(message);
        }
      });

      describe('the message has an origin different then the api client url', function () {
        beforeEach(function () {
          message.origin = 'someUrl1';
          DataStore.apiClientUrl = 'someUrl2';
        });

        it('returns false', function () {
          expect(subject()).toBe(false);
        });
      });

      describe('the message has the same origin as the api client url', function () {
        beforeEach(function () {
          message.origin = 'someUrl1';
          DataStore.apiClientUrl = 'someUrl1';
        });

        it('returns true', function () {
          expect(subject()).toBe(true);
        });
      });
    });

    describe('handle', function () {
      var message;

      beforeEach(function () {
        message = {};
        subject = function () {
          instance.handle(message);
        }
      });

      describe('the message is authorized', function () {
        beforeEach(function () {
          message.origin = 'someUrl1';
          DataStore.apiClientUrl = 'someUrl1';
        });

        describe('the message has a serialized JSON object as its data', function () {
          var options;
          beforeEach(function () {
            options = {};
            subject = function () {
              message.data = JSON.stringify(options);
              return instance.handle(message);
            }
          });

          describe('the action property of the options object is getUserAccessToken', function () {
            beforeEach(function () {
              options.action = 'getUserAccessToken';
            });

            it('posts a message to the source of the message with the user access token from the DataStore', function () {
              DataStore.userAccessToken = 'someToken';
              message.source = jasmine.createSpyObj('source', ['postMessage']);

              subject();

              var sentMessage = JSON.stringify({action: 'setUserAccessToken', data: 'someToken'});
              expect(message.source.postMessage).toHaveBeenCalledWith(sentMessage, DataStore.omnipasteUrl);
            });
          });
        });
      });
    });
  });
});