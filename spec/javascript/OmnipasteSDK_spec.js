define(['OmnipasteSDK', 'sdk/Initializer'], function (OmnipasteSDK, Initializer) {
  describe('OmnipasteSDK', function () {
    var subject, instance;

    beforeEach(function () {
      instance = new OmnipasteSDK();
      subject = function () {
        return instance;
      };
    });

    it('has an initialize function', function () {
      expect(subject().initialize).not.toBeUndefined(true);
    });

    it('has an instance of Initializer as its initializer', function () {
      expect(subject().initializer instanceof Initializer).toBe(true);
    });

    describe('initialize', function () {
      var clientId;

      beforeEach(function () {
        clientId = '12345';
        subject = function () {
          instance.initialize(clientId);
        }
      });

      it('calls run on its initializer with the given client id', function () {
        var spy = spyOn(instance.initializer, 'run');

        subject();

        expect(spy).toHaveBeenCalledWith(clientId)
      });
    });
  });
});