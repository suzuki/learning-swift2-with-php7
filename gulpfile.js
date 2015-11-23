var gulp    = require('gulp');
var shell   = require('gulp-shell');

gulp.task('exec php', function() {
  gulp.src(['php/*.php'])
    .pipe(shell([
      '/usr/bin/env php <%= file.path %>',
    ]));
});

gulp.task('exec swift', function() {
  gulp.src(['swift/*.swift'])
    .pipe(shell([
      '/usr/bin/env swift <%= file.path %>',
    ]));
});

gulp.task('default', function() {
  gulp.watch(['php/*.php'],     ['exec php']);
  gulp.watch(['swift/*.swift'], ['exec swift']);
});
