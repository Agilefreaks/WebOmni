define(['sdk/RESTAPIClient', 'jquery', 'sdk/DataStore', 'sdk/helpers/Promise'],
  function (RESTAPIClient, $, DataStore, PromiseHelper) {
    describe('sdk/RESTAPIClient', function () {
      var instance, subject;

      beforeEach(function () {
        instance = new RESTAPIClient();
        subject = function () {
          return instance;
        }
      });

      describe('getInstance', function () {
        beforeEach(function () {
          subject = function () {
            return RESTAPIClient.getInstance();
          }
        });

        it('returns an instance of JSAPIClient', function () {
          expect(subject() instanceof RESTAPIClient).toBe(true);
        });

        it('returns the same instance of JSAPIClient on consecutive calls', function () {
          var result1 = subject();
          var result2 = subject();

          expect(result2).toBe(result1);
        });
      });

      describe('createPhoneCall', function () {
        var phoneCall;
        beforeEach(function () {
          phoneCall = {number: '1234'};
          subject = function () {
            return instance.createPhoneCall(phoneCall);
          }
        });

        it('makes an ajax request to the phone calls endpoint of the api', function () {
          DataStore.omnipasteAPIUrl = 'http://some.url.com';
          var spy = spyOn($, 'ajax');

          subject();

          expect(spy).toHaveBeenCalledWith(jasmine.objectContaining({url: 'http://some.url.com/phone_calls'}));
        });

        it('sets POST as the http verb on the ajax request', function () {
          var spy = spyOn($, 'ajax');

          subject();

          expect(spy).toHaveBeenCalledWith(jasmine.objectContaining({method: 'POST'}));
        });

        it('sets the user access token in the request header', function () {
          var spy = spyOn($, 'ajax');
          DataStore.userAccessToken = 'someUserToken';

          subject();

          var expectedHeaders = {'Authorization': 'Bearer someUserToken'};
          expect(spy).toHaveBeenCalledWith(jasmine.objectContaining({headers: expectedHeaders}));
        });

        it('sets the the data type of the request to JSON', function () {
          var spy = spyOn($, 'ajax');

          subject();

          expect(spy).toHaveBeenCalledWith(jasmine.objectContaining({dataType: 'JSON'}));
        });

        it('sets the given phoneCall object as the request data', function () {
          var spy = spyOn($, 'ajax');

          subject();

          expect(spy).toHaveBeenCalledWith(jasmine.objectContaining({data: phoneCall}));
        });

        describe('the request is completed successfully', function () {
          var response;
          beforeEach(function () {
            response = {
              "id": "553a534e5562751c19060000",
              "created_at": "2015-04-24T14:29:34Z",
              "updated_at": "2015-04-24T14:29:34Z",
              "number": "+40755808037",
              "contact_name": null,
              "contact_id": null
            };
            spyOn($, 'ajax').andReturn(PromiseHelper.resolvedPromise(response));
          });

          it('resolves the returned promise with the request response', function() {
            var result;
            subject().done(function (obtainedResponse) {
              result = obtainedResponse;
            });

            waitsFor(function() {
              return result == response;
            }, 'the create call promise to finish', 500);
          });
        });
      });
    });
  });