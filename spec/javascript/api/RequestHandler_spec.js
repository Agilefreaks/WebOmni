define(['api/RequestHandler', 'api/DataStore', 'api/Commands/CommandFactory', 'api/Commands/EmptyCommand'],
  function (RequestHandler, DataStore, CommandFactory, EmptyCommand) {
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

        it('it creates a command for the given message', function () {
          var spy = spyOn(CommandFactory.prototype, 'create').andReturn(new EmptyCommand());

          subject();

          expect(spy).toHaveBeenCalledWith(message)
        });

        it('executes the obtained command', function () {
          var command = new EmptyCommand();
          var spy = spyOn(command, 'execute');
          spyOn(CommandFactory.prototype, 'create').andReturn(command);

          subject();

          expect(spy).toHaveBeenCalled()
        });
      });
    });
  });
});