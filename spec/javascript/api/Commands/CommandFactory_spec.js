define(['lodash', 'api/Commands/CommandFactory', 'api/Commands/EmptyCommand', 'api/Commands/GetUserAccessTokenCommand'],
  function (_, CommandFactory, EmptyCommand, GetUserAccessTokenCommand) {
    describe('api/Commands/GetUserAccessTokenCommand', function () {
      var instance, subject;

      beforeEach(function () {
        instance = new CommandFactory();
        subject = function () {
          return instance;
        }
      });

      describe('create', function () {
        var message;

        beforeEach(function () {
          message = {};
          subject = function () {
            return instance.create(message);
          }
        });

        describe('a message is given with non json data', function () {
          _.each([1, 2, '12', undefined, null, '{]', 'asf', '[0'], function (invalidData) {
            beforeEach(function () {
              message.data = invalidData;
            });

            it('returns an empty command', function () {
              expect(subject()).toEqual(jasmine.any(EmptyCommand));
            });
          });
        });

        describe('a message is given with action name getUserAccessToken', function () {
          beforeEach(function () {
            message.data = JSON.stringify({action: 'getUserAccessToken'});
          });

          it('returns an empty command', function () {
            expect(subject()).toEqual(jasmine.any(GetUserAccessTokenCommand));
          });
        });

        describe('a message is given with an unknown name', function () {
          beforeEach(function () {
            message.data = JSON.stringify({action: 'someUnknownName'});
          });

          it('returns an empty command', function () {
            expect(subject()).toEqual(jasmine.any(EmptyCommand));
          });
        });
      });
    });
  });