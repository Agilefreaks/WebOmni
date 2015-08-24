define(['sdk/PhoneClickHandler', 'jquery'],
  function (PhoneClickHandler, $) {
    var instance, subject;

    describe('PhoneClickHandler', function() {
      beforeEach(function() {
        instance = new PhoneClickHandler();
      });

      describe('initialize', function() {
        beforeEach(function() {
          instance.initialize();
        });

        afterEach(function() {
          instance.dispose();
        });

        describe('events', function () {
          describe('an html element exists in the dom with the data-omnipaste-call attribute', function () {
            var htmlElement;

            beforeEach(function () {
              htmlElement = $('<div data-omnipaste-call="0000111222"></div>').appendTo($('body'));
            });

            afterEach(function () {
              htmlElement.remove();
            });

            describe('clicking the element', function () {
              beforeEach(function () {
                subject = function () {
                  htmlElement.click();
                }
              });

              it('calls handleCallRequest on the request handler with the phone number', function () {
                var spy = spyOn(instance.requestHandler, 'handleCallRequest');

                subject();

                expect(spy).toHaveBeenCalledWith({phoneNumber: '0000111222'});
              });

              describe('after dispose', function() {
                beforeEach(function() {
                  instance.dispose();
                });

                it('does not call handleCallRequest on the request handler', function () {
                  var spy = spyOn(instance.requestHandler, 'handleCallRequest');

                  subject();

                  expect(spy).not.toHaveBeenCalledWith({phoneNumber: '0000111222'});
                });
              });
            });
          });
        });
      });
    });
  });