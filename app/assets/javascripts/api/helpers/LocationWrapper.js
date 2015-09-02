define('api/helpers/LocationWrapper', [], function () {
  var LocationWrapper = {
    navigate: function(path) {
      window.location.href = path;
    }
  };

  return LocationWrapper;
});