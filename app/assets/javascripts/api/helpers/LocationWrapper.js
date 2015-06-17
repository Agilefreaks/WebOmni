define('api/helpers/LocationWrapper', [], function () {
  var LocationWrapper = {
    navigate: function(path) {
      window.location.pathname = path;
    }
  };

  return LocationWrapper;
});