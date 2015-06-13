var gulp = require('gulp'),
	browserify = require('browserify'),
	buffer = require('gulp-buffer'),
	source = require('vinyl-source-stream'),
	sourcemaps = require('gulp-sourcemaps'),
	gutil = require('gulp-util'),
	jshint = require('gulp-jshint'),
	uglify = require('gulp-uglify'),
	stylish = require('jshint-stylish'),
	compass = require('gulp-compass');

gulp.task('lint', function(){
	return gulp.src('js/src/**/*.js')
		.pipe(jshint())
		.pipe(jshint.reporter(stylish));
});

gulp.task('scripts', function(){
	var bundler = browserify({
		entries: ['./_js/app.js'],
		debug: true
	});

	return bundler.bundle()
		.on('error', function(err) {
			gutil.log(err.message);
			gutil.beep();
			this.emit('end');
		})
		.pipe(source('app.js'))
		.pipe(buffer())
		.pipe(sourcemaps.init({loadMaps: true}))
    .pipe(uglify())
    .pipe(sourcemaps.write('./', {
    	sourceRoot: '../'
    }))
		.pipe(gulp.dest('./js'));
});

gulp.task('compass', function() {
  gulp.src('_scss/src/*.scss')
    .pipe(compass({
      config_file: 'config.rb',
      css: 'css',
      sass: '_scss'
    }))
    .pipe(gulp.dest('app/assets/temp'));
});

gulp.task('watch', function (){
	var watcher = gulp.watch(['_js/**/*.js','_hbs/**/*.hbs'], ['scripts']);
		gulp.watch('./_scss/src/*.scss', ['compass']);
});

