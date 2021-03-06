define(['sdk/ComChannel', 'sdk/DataStore', 'sdk/helpers/WindowWrapper', 'jquery', 'lodash'],
  function (ComChannel, DataStore, WindowWrapper, $, _) {
    describe('ComChannel', function () {
      var instance, subject;

      function createFakeWindow() {
        var fakeWindow = jasmine.createSpyObj('window', ['close']);
        fakeWindow.closed = false;
        fakeWindow.close.andCallFake(function() {
          fakeWindow.closed = true;
        });

        return fakeWindow;
      }

      beforeEach(function () {
        //the following is required to prevent cross-origin issues during tests
        DataStore.omnipasteUrl = 'http://localhost:9876';
        instance = new ComChannel();
        subject = function () {
          return instance;
        }
      });

      describe('open', function () {
        var endpoint;
        beforeEach(function () {
          endpoint = 'someEndpoint';
          DataStore.clientId = 'someId';
          subject = function () {
            return instance.open(endpoint);
          }
        });

        afterEach(function () {
          instance.dispose();
        });

        it('opens a window pointing to the correct omnipaste url', function () {
          var spy = spyOn(WindowWrapper, 'open').andReturn(createFakeWindow());

          subject();

          waitsFor(function () {
            return spy.calls.length > 0;
          }, 'the new window to navigate to the omnipaste url', 1000);
          runs(function () {
            expect(spy.calls[0].args[0]).toEqual('http://localhost:9876/api/someId/someEndpoint?locale=en');
          });
        });

        describe('opening a window works', function() {
          var openedWindow;

          beforeEach(function() {
            openedWindow = createFakeWindow();
            spyOn(WindowWrapper, 'open').andReturn(openedWindow);
          });

          it('sets the opened window on the ComChannel', function () {
            subject();

            expect(instance.targetWindow).toBe(openedWindow);
          });

          describe('after opening the window an apiReady message is received', function () {
            beforeEach(function () {
              WindowWrapper.open.andCallFake(function () {
                window.postMessage(JSON.stringify({action: 'apiReady'}), DataStore.omnipasteUrl);
                return openedWindow;
              });
            });

            it('resolves the returned promise', function () {
              var wasResolved = false;
              subject().done(function () {
                wasResolved = true;
              });

              waitsFor(function () {
                return wasResolved;
              }, 'the promise to be resolved', 1000);
            });
          });

          describe('after opening the window the window is closed before receiving an apiReady message', function () {
            beforeEach(function () {
              WindowWrapper.open.andCallFake(function () {
                _.defer(function() {
                  openedWindow.closed = true;
                });
                return openedWindow;
              });
            });

            it('rejects the returned promise', function () {
              var wasRejected = false;
              subject().fail(function () {
                wasRejected = true;
              });

              waitsFor(function () {
                return wasRejected;
              }, 'the promise to be rejected', 1000);
            });
          });
        });

        describe('opening the window fails', function () {
          beforeEach(function () {
            spyOn(WindowWrapper, 'open').andReturn(null);
          });

          it('rejects the returned promise', function () {
            var wasRejected = false;
            subject().fail(function () {
              wasRejected = true;
            });

            waitsFor(function () {
              return wasRejected;
            }, 'the promise to be rejected', 1000);
          })
        });
      });

      describe('dispose', function () {
        beforeEach(function () {
          subject = function () {
            instance.dispose();
          }
        });

        describe('a window object was previously created', function () {
          var createdWindow;
          beforeEach(function () {
            createdWindow = createFakeWindow();
            instance.targetWindow = createdWindow;
          });

          it('closes the window opened by the SDK', function () {
            subject();

            expect(createdWindow.close).toHaveBeenCalled();
          });
        });

        describe('receiving a valid window message event after the call', function () {
          var message;
          beforeEach(function () {
            message = {action: 'apiReady'};
            DataStore.omnipasteUrl = 'http://localhost:9876';
            subject = function () {
              instance.dispose();
              window.postMessage(JSON.stringify(message), '*');
            }
          });

          describe('the com channel has been previously opened', function () {
            beforeEach(function () {
              spyOn(WindowWrapper, 'open').andReturn(createFakeWindow());
              instance.open('someEndpoint');
            });

            it('does not trigger an event with the action name contained in the message', function () {
              var wasTriggered = false;
              instance.on('apiReady', function () {
                wasTriggered = true;
              });

              var timeElapsed;
              setTimeout(function () {
                timeElapsed = true;
              }, 500);

              subject();

              waitsFor(function () {
                return timeElapsed;
              }, 'the event to be triggered', 700);

              runs(function () {
                expect(wasTriggered).toBe(false);
              });
            });
          });
        });
      });

      describe('the channel is open', function () {
        beforeEach(function () {
          spyOn(WindowWrapper, 'open').andReturn(createFakeWindow());
          instance.open('someEndpoint');
        });

        afterEach(function () {
          instance.dispose();
        });

        describe('receiving a window message event', function () {
          var message;
          beforeEach(function () {
            message = {action: 'apiReady'};
            subject = function () {
              window.postMessage(JSON.stringify(message), '*');
            }
          });

          describe('the message origin matches the omnipaste url', function () {
            beforeEach(function () {
              DataStore.omnipasteUrl = 'http://localhost:9876';
            });

            it('triggers an event with the action name contained in the message', function () {
              var wasTriggered;
              instance.on('apiReady', function () {
                wasTriggered = true;
              });

              subject();

              waitsFor(function () {
                return wasTriggered;
              }, 'the event to be triggered', 500);
            });

            describe('the message has a data property', function () {
              beforeEach(function () {
                message.data = {someProp: 'someValue'};
              });

              it('triggers the event with the message data as a parameter', function () {
                var eventData = null;
                instance.on('apiReady', function (data) {
                  eventData = data;
                });

                subject();

                waitsFor(function () {
                  return _.isEqual(eventData, {someProp: 'someValue'});
                }, 'the event to be triggered', 500);
              });
            });
          });

          describe('the message origin does not match the omnipaste url', function () {
            beforeEach(function () {
              DataStore.omnipasteUrl = 'http://someUrl';
            });

            it('does not trigger an event with the action name contained in the message', function () {
              var wasTriggered = false;
              instance._uid = '1';
              instance.on('apiReady', function () {
                wasTriggered = true;
              });

              var timeElapsed;
              setTimeout(function () {
                timeElapsed = true;
              }, 500);

              subject();

              waitsFor(function () {
                return timeElapsed;
              }, 'the event to be triggered', 700);

              runs(function () {
                expect(wasTriggered).toBe(false);
              });
            });
          });
        });

        describe('closing the window', function () {
          beforeEach(function () {
            subject = function () {
              instance.targetWindow.close();
            }
          });

          it('triggers a channelClosed event', function () {
            var wasTriggered = false;
            instance.on('channelClosed', function () {
              wasTriggered = true;
            });

            subject();

            waitsFor(function () {
              return wasTriggered;
            }, 'the channelClosed event to be raised', 500);
          });
        });
      });
    });
  });