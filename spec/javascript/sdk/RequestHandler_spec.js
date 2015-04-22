define(
  ['sdk/RequestHandler', 'sdk/DataStore', 'sdk/JSAPIClient', 'sdk/helpers/Promise'],
  function (RequestHandler, DataStore, JSAPIClient, PromiseHelper) {
    var instance, subject;

    beforeEach(function () {
      instance = new RequestHandler();
      subject = function () {
        return instance;
      }
    });

    describe('handleCallRequest', function () {
      var request;
      beforeEach(function () {
        request = {};
        subject = function () {
          instance.handleCallRequest(request);
        }
      });

      describe('the DataStore does not have a userAccessToken', function () {
        beforeEach(function () {
          delete DataStore['userAccessToken'];
        });

        function setupJSAPIClient() {
          var mockClient = jasmine.createSpyObj('apiClient', ['getUserAccessToken']);
          mockClient.getUserAccessToken.andReturn(PromiseHelper.resolvedPromise('someToken'));
          spyOn(JSAPIClient, 'getInstance').andReturn(mockClient);

          return mockClient;
        }

        it('calls getUserAccessToken on the JSAPIClient instance', function () {
          var mockClient = setupJSAPIClient();

          subject();

          expect(mockClient.getUserAccessToken).toHaveBeenCalled();
        });

        describe('the getUserAccessToken call returns a promise which is resolved', function () {
          beforeEach(function () {
            setupJSAPIClient();
          });

          it('stores the obtained token', function () {
            subject();

            waitsFor(function() {
              return DataStore.userAccessToken === 'someToken';
            }, 'the token to be stored', 500);
          });
        });
      });
    });
  });