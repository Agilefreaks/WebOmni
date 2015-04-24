define(
  ['sdk/RequestHandler', 'sdk/DataStore', 'sdk/JSAPIClient', 'sdk/helpers/Promise', 'sdk/RESTAPIClient'],
  function (RequestHandler, DataStore, JSAPIClient, PromiseHelper, RESTAPIClient) {
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
          return instance.handleCallRequest(request);
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

            waitsFor(function () {
              return DataStore.userAccessToken === 'someToken';
            }, 'the token to be stored', 500);
          });
        });
      });

      describe('the DataStore has a stored userAccessToken', function () {
        beforeEach(function () {
          DataStore.userAccessToken = 'someToken';
        });

        it('creates a new phone call using the REST API', function () {
          var spy = spyOn(RESTAPIClient.getInstance(), 'createPhoneCall');

          subject();

          waitsFor(function() {
            return spy.calls.length > 0;
          }, 'createPhoneCall to be called', 500);
        });

        describe('the promise obtained from the REST client is resolved', function() {
          beforeEach(function() {
            spyOn(RESTAPIClient.getInstance(), 'createPhoneCall').andReturn(PromiseHelper.resolvedPromise('someCallId'));
          });

          it('resolves the returned promise with the call id', function () {
            var callId;
            subject().done(function(obtainedCallId) {
              callId = obtainedCallId;
            });

            waitsFor(function() {
              return callId == 'someCallId';
            }, 'the promise to be resolved', 500);
          });
        });
      });
    });
  });