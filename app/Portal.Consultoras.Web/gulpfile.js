/// <binding AfterBuild='unit-test-js' />
/*
This file is the main entry point for defining Gulp tasks and using Gulp plugins.
Click here to learn more. https://go.microsoft.com/fwlink/?LinkId=518007
*/

var gulp = require('gulp');
var path = require('path');
var iisexpress = require('gulp-serve-iis-express');
var Server = require('karma').Server;

/**
 * Run test once and exit
 */
gulp.task('unit-test-js', function (done) {
    var configPath = path.join(__dirname, '..\\.vs\\config\\applicationHost.config');

    //iisexpress({
    //    siteNames: ['Portal.Consultoras.Web'],
    //    configFile: configPath
    //});

    new Server({
        configFile: __dirname + '/karma.conf.js',
        singleRun: true
    }, done).start();
});