var allTestFiles = [];
var TEST_REGEXP = /spec\.js$/;

Object.keys(window.__karma__.files).forEach(function(file) {
  if (TEST_REGEXP.test(file)) {
    allTestFiles.push(file);
  }
});

require.config({
  // Karma serves files under /base, which is the basePath from your config file
  baseUrl: '/base/app/assets/javascripts',

  // example of using shim, to load non AMD libraries (such as underscore and jquery)
  paths: {
    jquery: '../../../vendor/assets/javascripts/jquery.2.1.1',
    lodash: '../../../vendor/assets/javascripts/lodash',
    EventEmitter: '../../../vendor/assets/javascripts/eventEmitter',
    SimpleModal: '../../../vendor/assets/javascripts/simpleModal'
  },

  // dynamically load all test files
  deps: allTestFiles,

  // we have to kickoff jasmine, as it is asynchronous
  callback: window.__karma__.start
});
