define(['api/Commands/ShowCallInProgressCommand', 'api/DataStore'], function (ShowCallInProgressCommand, DataStore) {
  describe('api/Commands/ShowCallInProgressCommand', function () {
    var instance, router, subject;

    beforeEach(function () {
      router = jasmine.createSpyObj('router', ['navigate']);
      instance = new ShowCallInProgressCommand(router);
      DataStore.clientId = 'someClientToken';
      DataStore.clientLocale = 'en';
      subject = function () {
        return instance;
      }
    });

    describe('execute', function () {
      beforeEach(function() {
        subject = function() {
          return instance.execute();
        }
      });

      it('navigates to the call in progress page', function() {
        subject();

        expect(router.navigate).toHaveBeenCalledWith('/api/someClientToken/call_in_progress?locale=en');
      });
    });
  });
});