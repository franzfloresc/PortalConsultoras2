// Karma configuration
// Generated on Mon Jan 07 2019 15:49:13 GMT-0500 (SA Pacific Standard Time)

module.exports = function (config) {
    config.set({

        // base path that will be used to resolve all patterns (eg. files, exclude)
        basePath: '',


        // frameworks to use
        // available frameworks: https://npmjs.org/browse/keyword/karma-adapter
        frameworks: [
            'jasmine',
        ],


        // list of files / patterns to load in the browser
        files: [
            // Libraries and dependencies
            'Scripts/jquery-1.11.2.min.js',
            'Scripts/jquery-ui-1.9.2.custom.js',
            'Scripts/handlebars.js',

            // General
            'Scripts/General.js',

            // FichaModule
            'Scripts/PortalConsultoras/Shared/ConstantesModule.js',
            'Scripts/PortalConsultoras/EstrategiaPersonalizada/LocalStorage.js',
            'Scripts/PortalConsultoras/DetalleEstrategia/FichaModule.js',
            'Scripts/tests/PortalConsultoras/DetalleEstrategia/FichaModuleSpec.js'
        ],


        // list of files / patterns to exclude
        exclude: [
        ],


        // preprocess matching files before serving them to the browser
        // available preprocessors: https://npmjs.org/browse/keyword/karma-preprocessor
        preprocessors: {
        },


        // test results reporter to use
        // possible values: 'dots', 'progress'
        // available reporters: https://npmjs.org/browse/keyword/karma-reporter
        reporters: ['progress'],


        // web server port
        port: 9876,


        // enable / disable colors in the output (reporters and logs)
        colors: true,


        // level of logging
        // possible values: config.LOG_DISABLE || config.LOG_ERROR || config.LOG_WARN || config.LOG_INFO || config.LOG_DEBUG
        logLevel: config.LOG_INFO,


        // enable / disable watching file and executing tests whenever any file changes
        autoWatch: true,


        // start these browsers
        // available browser launchers: https://npmjs.org/browse/keyword/karma-launcher
        browsers: ['Chrome'],


        // Continuous Integration mode
        // if true, Karma captures browsers, runs the tests and exits
        singleRun: false,

        // Concurrency level
        // how many browser should be started simultaneous
        concurrency: Infinity
    })
}
