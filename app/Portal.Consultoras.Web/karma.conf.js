// Karma configuration
// Generated on Mon Jan 07 2019 15:49:13 GMT-0500 (SA Pacific Standard Time)

module.exports = function (config) {
    config.set({

        // base path that will be used to resolve all patterns (eg. files, exclude)
        basePath: '',


        // frameworks to use
        // available frameworks: https://npmjs.org/browse/keyword/karma-adapter
        frameworks: [
            'mocha',
            'chai',
            'sinon',
        ],


        // list of files / patterns to load in the browser
        files: [
            // Libraries and dependencies
            'Scripts/jquery-1.11.2.min.js',
            'Scripts/jquery-ui-1.9.2.custom.js',
            'Scripts/handlebars.js',
            // 'node_modules/Sinon/pkg/sinon.js',
            'node_modules/core-js/client/core.js',
            'Scripts/tests/TestHelpersModule.js',

            // General
            'Scripts/General.js',

            // FichaModule
            'Scripts/PortalConsultoras/Shared/ConstantesModule.js',
            'Scripts/PortalConsultoras/EstrategiaPersonalizada/LocalStorage.js',
            'Scripts/PortalConsultoras/TusClientes/TusClientesProvider.js',
            'Scripts/PortalConsultoras/TusClientes/PanelListaModule.js',
            'Scripts/PortalConsultoras/TusClientes/PanelMantenerModule.js',
            'Scripts/PortalConsultoras/TusClientes/ClientePanelModule.js',
            'Scripts/PortalConsultoras/DetalleEstrategia/DetalleEstrategiaProvider.js',
            'Scripts/PortalConsultoras/DetalleEstrategia/FichaModule.js',

            // TusClientes
            'Scripts/PortalConsultoras/TusClientes/TusClientesView.js',
            'Scripts/PortalConsultoras/TusClientes/TusClientesModule.js',

            // ArmaTuPack
            'Scripts/PortalConsultoras/ArmaTuPack/Detalle/Cabecera/CabeceraPresenter.js',
            'Scripts/PortalConsultoras/ArmaTuPack/Detalle/Cabecera/CabeceraView.js',
            'Scripts/PortalConsultoras/ArmaTuPack/Detalle/Grupo/GrupoPresenter.js',
            'Scripts/PortalConsultoras/ArmaTuPack/Detalle/Grupo/GrupoMobileView.js',
            'Scripts/PortalConsultoras/ArmaTuPack/Detalle/Grupo/GrupoDesktopView.js',
            'Scripts/PortalConsultoras/ArmaTuPack/Detalle/Seleccionados/SeleccionadosPresenter.js',
            'Scripts/PortalConsultoras/ArmaTuPack/Detalle/Seleccionados/SeleccionadosView.js',
            'Scripts/PortalConsultoras/ArmaTuPack/Detalle/DetallePresenter.js',
            'Scripts/PortalConsultoras/ArmaTuPack/ArmaTuPackProvider.js',

            // Specs
            'Scripts/tests/PortalConsultoras/DetalleEstrategia/FichaModuleSpec.js',
            //
            'Scripts/tests/PortalConsultoras/TusClientes/TusClientesModuleSpec.js',
            //
            'Scripts/tests/PortalConsultoras/ArmaTuPack/Detalle/Cabecera/CabeceraPresenterSpec.js',
            'Scripts/tests/PortalConsultoras/ArmaTuPack/Detalle/Grupo/GrupoPresenterSpec.js',
            'Scripts/tests/PortalConsultoras/ArmaTuPack/Detalle/Seleccionados/SeleccionadosPresenterSpec.js',
            'Scripts/tests/PortalConsultoras/ArmaTuPack/Detalle/DetallePresenterSpec.js'
        ],


        // list of files / patterns to exclude
        exclude: [
        ],


        // preprocess matching files before serving them to the browser
        // available preprocessors: https://npmjs.org/browse/keyword/karma-preprocessor
        preprocessors: {
            'Scripts/PortalConsultoras/**/*.js': ['coverage']
        },


        // test results reporter to use
        // possible values: 'dots', 'progress'
        // available reporters: https://npmjs.org/browse/keyword/karma-reporter
        reporters: [
            //'progress',
            'mocha',
            'coverage',
        ],

        coverageReporter: {
            type: 'text'
        },      

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
        browsers: [
            'ChromeDebugging'
            //'Chrome'
            //'PhantomJS'
        ],

        customLaunchers: {
            ChromeDebugging: {
                base: 'Chrome',
                flags: ['--remote-debugging-port=9222'],
                debug: true
            }
        },

        browserNoActivityTimeout: 100000,
        
        // Continuous Integration mode
        // if true, Karma captures browsers, runs the tests and exits
        singleRun: false,

        // Concurrency level
        // how many browser should be started simultaneous
        concurrency: Infinity
    });
};
