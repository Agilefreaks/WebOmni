define(['api/Commands/GetUserAccessTokenCommand', 'api/DataStore'], function (GetUserAccessTokenCommand, DataStore) {
  describe('api/Commands/GetUserAccessTokenCommand', function () {
    var instance, source, subject;

    beforeEach(function () {
      source = jasmine.createSpyObj('source', ['postMessage']);
      instance = new GetUserAccessTokenCommand(source);
      subject = function () {
        return instance;
      }
    });

    describe('execute', function () {
      beforeEach(function () {
        subject = function() {
          instance.execute();
        }
      });

      it('sends a setUserAccessToken message to the given source with the userAccessToken', function() {
        DataStore.userAccessToken = 'someUserToken';
        DataStore.omnipasteUrl = 'http://some.url';

        subject();

        expect(source.postMessage).toHaveBeenCalledWith(JSON.stringify({
          action: 'setUserAccessToken',
          data: 'someUserToken'
        }), 'http://some.url');
      })
    });
  });
});