/// <binding BeforeBuild='minify-js' />

/*
This file is the main entry point for defining Gulp tasks and using Gulp plugins.
Click here to learn more. https://go.microsoft.com/fwlink/?LinkId=518007
*/

var gulp = require('gulp');
var minify = require('gulp-minify');

gulp.task('minify-js', function () {
    gulp
        .src('scripts/PortalConsultoras/MatrizCampania/*.js')
        .pipe(minify({
            ext: {
                src: '.js',
                min: '.min.js'
            },
            ignoreFiles: ['*.min.js'],
            mangle: false
        })).pipe(gulp.dest('scripts/PortalConsultoras/MatrizCampania'));
});