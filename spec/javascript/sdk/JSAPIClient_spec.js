define(['sdk/JSAPIClient', 'sdk/ComChannel'], function (JSAPIClient, ComChannel) {
  describe('JSAPIClient', function () {
    var instance, subject, openChannelSpy;

    beforeEach(function () {
      //the following line is required so as to not actually try to open a ComChannel while in a test env
      openChannelSpy = spyOn(ComChannel.prototype, 'open');
      instance = new JSAPIClient();
      subject = function () {
        return instance;
      }
    });

    describe('getInstance', function () {
      beforeEach(function () {
        subject = function () {
          return JSAPIClient.getInstance();
        }
      });

      it('returns an instance of JSAPIClient', function () {
        expect(subject() instanceof JSAPIClient).toBe(true);
      });

      it('returns the same instance of JSAPIClient on consecutive calls', function () {
        var result1 = subject();
        var result2 = subject();

        expect(result2).toBe(result1);
      });
    });

    describe('initialize', function () {
      var endpoint;

      beforeEach(function () {
        endpoint = 'someEndpoint';
        subject = function () {
          return instance.initialize(endpoint);
        }
      });

      describe('the client has not yet been initialized', function () {
        beforeEach(function () {
          instance.reset();
        });

        it('creates a new comChannel', function () {
          subject();

          expect(instance.comChannel instanceof ComChannel).toBe(true);
        });

        it('opens the channel with the given endpoint', function() {
          subject();

          expect(openChannelSpy).toHaveBeenCalledWith(endpoint);
        });

        describe('an apiReady event is triggered on the ComChannel after the initialize call is made', function () {
          beforeEach(function () {
            subject = function () {
              var promise = instance.initialize();
              instance.comChannel.trigger('apiReady');
              return promise;
            }
          });

          it('resolves the returned promise', function () {
            var resolvedPromise;
            subject().done(function () {
              resolvedPromise = true;
            });

            waitsFor(function () {
              return resolvedPromise;
            }, 'the promise to be resolved', 500);
          });
        });

        it('returns the same promise on successive calls while the apiReady event has not been triggered', function () {
          var promise1 = subject();
          var promise2 = subject();

          expect(promise2).toBe(promise1);
        });
      });
    });

    describe('reset', function () {
      beforeEach(function () {
        subject = function () {
          instance.reset();
        }
      });

      describe('was previously initialized', function () {
        beforeEach(function () {
          instance.initialize('someEndpoint');
          instance.comChannel.trigger('apiReady');
        });

        it('disposes the comChannel', function () {
          var spy = spyOn(instance.comChannel, 'dispose').andCallThrough();

          subject();

          expect(spy).toHaveBeenCalled();
        });
      });
    });
  });
});