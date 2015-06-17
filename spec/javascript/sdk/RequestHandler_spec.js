define(
  ['sdk/RequestHandler', 'sdk/DataStore', 'sdk/JSAPIClient', 'sdk/helpers/Promise', 'sdk/RESTAPIClient', 'lodash'],
  function (RequestHandler, DataStore, JSAPIClient, PromiseHelper, RESTAPIClient, _) {
    describe('sdk/RequestHandler', function () {
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
          request = {phoneNumber: '12345'};
          subject = function () {
            return instance.handleCallRequest(request);
          }
        });

        function checkCreationOfCall() {
          it('shows the call in progress dialog', function() {
            var spy = spyOn(JSAPIClient.getInstance(), 'showCallInProgress').andCallFake(PromiseHelper.resolvedPromise);

            subject();

            waitsFor(function() {
              return spy.calls.length > 0;
            }, 'call in progress to be shown', 500);
          });

          describe('after showing the call in progress dialog', function() {
            beforeEach(function() {
              spyOn(JSAPIClient.getInstance(), 'showCallInProgress').andCallFake(PromiseHelper.resolvedPromise);
            });

            it('creates a new phone call using the REST API', function () {
              var spy = spyOn(RESTAPIClient.getInstance(), 'createPhoneCall');

              subject();

              waitsFor(function () {
                return spy.calls.length > 0;
              }, 'createPhoneCall to be called', 500);

              runs(function () {
                expect(spy).toHaveBeenCalledWith({number: '12345', type: 'outgoing', state: 'starting'});
              });
            });

            describe('the promise obtained from the REST client is resolved', function () {
              beforeEach(function () {
                spyOn(RESTAPIClient.getInstance(), 'createPhoneCall').andReturn(PromiseHelper.resolvedPromise({id: 'someCallId'}));
              });

              it('resolves the returned promise with the call id', function () {
                var call;
                subject().done(function (obtainedCall) {
                  call = obtainedCall;
                });

                waitsFor(function () {
                  return _.isEqual(call, {id: 'someCallId'});
                }, 'the promise to be resolved', 500);
              });
            });
          });
        }

        describe('the DataStore does not have a userAccessToken', function () {
          beforeEach(function () {
            delete DataStore['userAccessToken'];
          });

          it('calls prepareForPhoneUsage on the JSAPIClient instance', function () {
            var spy = spyOn(JSAPIClient.getInstance(), 'prepareForPhoneUsage').andReturn(PromiseHelper.resolvedPromise());

            subject();

            waitsFor(function() {
              return spy.calls.length > 0;
            }, 'prepareForPhoneUsage to be called', 500);
          });

          describe('the prepareForPhoneUsage call returns a promise which is resolved', function () {
            beforeEach(function () {
              spyOn(JSAPIClient.getInstance(), 'prepareForPhoneUsage').andReturn(PromiseHelper.resolvedPromise('someToken'));
            });

            it('stores the obtained token', function () {
              subject();

              waitsFor(function () {
                return DataStore.userAccessToken === 'someToken';
              }, 'the token to be stored', 500);
            });

            checkCreationOfCall();
          });
        });

        describe('the DataStore has a stored userAccessToken', function () {
          beforeEach(function () {
            DataStore.userAccessToken = 'someToken';
          });

          checkCreationOfCall();
        });
      });
    });
  });