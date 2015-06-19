define(['sdk/JSAPIClient', 'sdk/ComChannel', 'sdk/helpers/Promise', 'lodash'], function (JSAPIClient, ComChannel, PromiseHelper, _) {
  describe('JSAPIClient', function () {
    var instance, subject, openChannelSpy;

    beforeEach(function () {
      //the following line is required so as to not actually try to open a ComChannel while in a test env
      openChannelSpy = spyOn(ComChannel.prototype, 'open').andReturn(PromiseHelper.resolvedPromise());
      var _instance;
      instance = function() {
        return _instance || (_instance = new JSAPIClient());
      };
      subject = function () {
        return instance();
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
      beforeEach(function () {
        subject = function () {
          return instance().initialize();
        }
      });

      describe('the client has not yet been initialized', function () {
        it('creates a new comChannel', function () {
          var spy = spyOn(ComChannel, 'create').andReturn(new ComChannel());

          subject();

          expect(spy).toHaveBeenCalled();
        });

        it('opens a com channel using the given endpoint', function () {
          subject();

          expect(openChannelSpy).toHaveBeenCalled();
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

        describe('opening the channel fails', function () {
          beforeEach(function() {
            openChannelSpy.andReturn(PromiseHelper.rejectedPromise());
          });

          it('rejects the returned promise', function () {
            var rejectedPromise;
            subject().fail(function () {
              rejectedPromise = true;
            });

            waitsFor(function () {
              return rejectedPromise;
            }, 'the promise to be rejected', 500);
          });

          it('returns a new promise when calling initialize again', function() {
            var rejectedPromise;
            var initialPromise = subject().fail(function () {
              rejectedPromise = true;
            });

            waitsFor(function () {
              return rejectedPromise;
            }, 'the promise to be rejected', 500);

            runs(function() {
              expect(subject()).not.toBe(initialPromise);
            });
          });
        });

        it('returns the same promise on successive calls while channel is/was opened', function () {
          openChannelSpy.andCallFake(PromiseHelper.resolvedPromise);
          var promise1 = subject();
          var promise2 = subject();

          expect(promise2).toBe(promise1);
        });
      });
    });

    describe('prepareForPhoneUsage', function () {
      beforeEach(function () {
        subject = function () {
          return instance().prepareForPhoneUsage();
        }
      });

      describe('the client has been initialized', function () {
        var comChannel;

        beforeEach(function () {
          comChannel = new ComChannel();
          spyOn(ComChannel, 'create').andReturn(comChannel);
          instance().initialize();
        });

        it('sends a getUserAccessToken request through the ComChannel', function () {
          var spy = spyOn(comChannel, 'send');

          subject();

          waitsFor(function () {
            return spy.calls.length > 0;
          }, 'send to be called', 500);

          runs(function () {
            expect(spy).toHaveBeenCalledWith({action: 'getUserAccessToken'});
          });
        });

        describe('it receives a setUserAccessToken message through the ComChannel', function () {
          beforeEach(function () {
            var previousSubject = subject;
            subject = function () {
              var promise = previousSubject();
              spyOn(comChannel, 'send').andCallFake(function(message) {
                if(message.action == 'getUserAccessToken') {
                  comChannel.trigger('setUserAccessToken', ['someToken']);
                }
              });
              return promise;
            }
          });

          it('resolves the returned promise with the obtained token', function () {
            var promiseResult = '';
            subject().done(function(result) {
              promiseResult = result;
            });

            waitsFor(function() {
              return promiseResult === 'someToken';
            }, 'the promise to be resolved', 500);
          });
        });

        describe('it receives a channelClosed message through the ComChannel', function () {
          beforeEach(function () {
            var previousSubject = subject;
            subject = function () {
              var promise = previousSubject();
              spyOn(comChannel, 'send').andCallFake(function(message) {
                if(message.action == 'getUserAccessToken') {
                  comChannel.trigger('channelClosed');
                }
              });
              return promise;
            }
          });

          it('disposes the ComChannel', function() {
            var spy = spyOn(comChannel, 'dispose');

            subject();

            waitsFor(function() {
              return spy.calls.length > 0;
            }, 'the com channel to be disposed', 500);
          });
        });
      });
    });

    describe('reset', function () {
      beforeEach(function () {
        subject = function () {
          instance().reset();
        }
      });

      describe('was previously initialized', function () {
        var comChannel;
        beforeEach(function () {
          comChannel = new ComChannel();
          spyOn(ComChannel, 'create').andReturn(comChannel);
          instance().initialize('someEndpoint');
        });

        it('disposes the comChannel', function () {
          var spy = spyOn(comChannel, 'dispose').andCallThrough();

          subject();

          expect(spy).toHaveBeenCalled();
        });
      });
    });
  });
});