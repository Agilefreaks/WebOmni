define(['sdk/Initializer', 'sdk/PhoneClickHandler', 'jquery', 'lodash', 'sdk/DataStore'],
  function (Initializer, PhoneClickHandler, $, _, DataStore) {
  describe('Initializer', function () {
    var subject, instance;

    beforeEach(function () {
      instance = new Initializer();
      subject = function () {
        return instance;
      };
    });

    it('has a run function', function () {
      expect(subject().run).not.toBeUndefined(true);
    });

    it('has a request handler', function () {
      expect(subject().phoneClickHandler instanceof PhoneClickHandler).toBe(true);
    });

    describe('run', function () {
      var clientId, omnipasteUrl, omnipasteAPIUrl;

      beforeEach(function() {
        omnipasteUrl = 'http://some.url';
        omnipasteAPIUrl = 'http://someOther.url';
        subject = function() {
          instance.run({clientId: clientId, omnipasteUrl: omnipasteUrl, omnipasteAPIUrl: omnipasteAPIUrl});
        }
      });

      afterEach(function() {
        instance.dispose();
      });

      _.each([null, undefined, false, '', {someProp: 'asa'}, 4], function(value) {
        describe('the given client id is ' + value, function () {
          beforeEach(function() {
            clientId = value;
          });

          it('throws an exception', function() {
            expect(subject).toThrow('Invalid api key');
          });
        });
      });

      describe('the given client id is a non empty string', function () {
        beforeEach(function() {
          clientId = 'testKey';
        });

        it('does not throw an exception', function() {
          expect(subject).not.toThrow('Invalid api key');
        });

        it('stores the given client id', function() {
          expect(DataStore.clientId).toEqual(clientId);
        });

        it('stores the give omnipasteUrl', function() {
          expect(DataStore.omnipasteUrl).toEqual(omnipasteUrl);
        });

        it('stores the give omnipasteAPIUrl', function() {
          expect(DataStore.omnipasteAPIUrl).toEqual(omnipasteAPIUrl);
        });
      });
    });
  });
});