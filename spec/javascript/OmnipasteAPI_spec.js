define(['OmnipasteAPI', 'api/Initializer'], function (OmnipasteAPI, Initializer) {
  describe('OmnipasteAPI', function () {
    var subject, instance;

    beforeEach(function () {
      instance = new OmnipasteAPI();
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
      beforeEach(function () {
        subject = function () {
          instance.initialize();
        }
      });

      it('calls run on its initializer', function () {
        var spy = spyOn(instance.initializer, 'run');

        subject();

        expect(spy).toHaveBeenCalled()
      });
    });
  });
});