// Karma configuration
// Generated on Mon Apr 20 2015 15:49:01 GMT+0300 (EEST)

module.exports = function(config) {
  config.set({

    // base path, that will be used to resolve files and exclude
    basePath: '../../',

    plugins: [
      'karma-jasmine',
      'karma-phantomjs-launcher',
      'karma-html-reporter',
      'karma-coverage',
      'karma-requirejs'
    ],

    // frameworks to use
    frameworks: ['jasmine', 'requirejs'],

    preprocessors: {
      '../../app/assets/javascripts/**/*.js': ['coverage']
    },

    // list of files / patterns to load in the browser
    files: [
      'spec/javascript/test-main.js',
      {pattern: 'app/assets/javascripts/**/*.js', included: false},
      {pattern: 'vendor/assets/javascripts/**/*.js', included: false},
      {pattern: 'spec/javascript/**/*.js', included: false}
    ],


    // list of files to exclude
    exclude: [
      'spec/javascript/karma.conf.js',
      'spec/javascript/results/**/*.*',
      'spec/javascript/coverage/**/*.*'
    ],


    // test results reporter to use
    // possible values: 'dots', 'progress', 'junit', 'growl', 'coverage'
    reporters: ['dots', 'coverage'],


    // web server port
    port: 9876,


    // enable / disable colors in the output (reporters and logs)
    colors: true,


    // level of logging
    // possible values: config.LOG_DISABLE || config.LOG_ERROR || config.LOG_WARN || config.LOG_INFO || config.LOG_DEBUG
    logLevel: config.LOG_INFO,


    // enable / disable watching file and executing tests whenever any file changes
    autoWatch: true,


    // Start these browsers, currently available:
    // - Chrome
    // - ChromeCanary
    // - Firefox
    // - Opera (has to be installed with `npm install karma-opera-launcher`)
    // - Safari (only Mac; has to be installed with `npm install karma-safari-launcher`)
    // - PhantomJS
    // - IE (only Windows; has to be installed with `npm install karma-ie-launcher`)
    browsers: ['PhantomJS'],


    // If browser does not capture in given timeout [ms], kill it
    captureTimeout: 60000,


    // Continuous Integration mode
    // if true, it capture browsers, run tests and exit
    singleRun: false,

    htmlReporter: {
      outputDir: 'results'
    },

    coverageReporter: {
      type : 'html',
      dir : 'coverage'
    }
  });
};
