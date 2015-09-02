define('sdk/helpers/WindowWrapper', [], function() {
  return {
    open: function() {
      return window.open.apply(null, arguments);
    },

    addEventListener: function() {
      return window.addEventListener.apply(null, arguments);
    },

    removeEventListener: function() {
      return window.removeEventListener.apply(null, arguments);
    }
  }
});