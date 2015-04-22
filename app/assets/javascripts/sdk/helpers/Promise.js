define('sdk/helpers/Promise', ['jquery', 'lodash'], function (jQuery, _) {
  var PromiseHelper = {
    completePromise: function (method, result, context) {
      var deferred = jQuery.Deferred();
      var promise = deferred.promise();
      method = arguments.length > 0 ? arguments[0] : 'resolveWith';
      var completeArguments = [];
      if (arguments.length > 1) {
        result = arguments[1];
        completeArguments.push(_.isFunction(result) ? result() : result);
      }

      context = arguments.length > 2 ? arguments[2] : promise;

      _.defer(function () {
        deferred[method](context, completeArguments);
      });

      return promise;
    },

    resolvedPromise: function () {
      var args = Array.prototype.slice.call(arguments);
      args.splice(0, 0, 'resolveWith');
      return PromiseHelper.completePromise.apply(this, args);
    },

    rejectedPromise: function () {
      var args = Array.prototype.slice.call(arguments);
      args.splice(0, 0, 'rejectWith');
      return PromiseHelper.completePromise.apply(this, args);
    }
  };

  return PromiseHelper;
});