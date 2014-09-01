'use strict';

module.exports = function (grunt) {

    var path = require('path');

    require('load-grunt-tasks')(grunt);
    require('time-grunt')(grunt);

    // configurable paths
    var yeomanConfig = {
        app: 'app',
        dist: 'dist'
    };

    require('load-grunt-config')(grunt, {
        configPath: path.join(process.cwd(), 'grunt'), //path to task.js files, defaults to grunt dir
        init: true, //auto grunt.initConfig
        config: {
        },
        loadGruntTasks: false
    });


    grunt.registerTask('serve', function (target) {
        if (target === 'dist') {
            return grunt.task.run(['build', 'open', 'connect:dist:keepalive']);
        }

        /* remember everything here is served from the .tmp/ and app/ folders so we don't need to do half
         * the stuff we do for a deploy like minification/uglification etc
         */
        grunt.task.run([
            'clean:server',                 // clean out .tmp folder
            'replace:config_development',   // replace configuration file with development environment specific settings
            'coffee',                       // compile coffeescript files
            'configureProxies',             // guess?
            'compass:server',               // compile scss files to a single css file located in .tmp/
            'copy:server',                  // need to get other resources like the jhb_ui partials into the .tmp/ folder
            'bless:local',                  // chop up the compass compiled css file into IE manageable chunks
            'connect:livereload',           // start livereload service; mounts the .tmp/ and app/ folders to serve via
                                            // localhost:9001; this means we can keep our application specific partials
                                            // and images where they are under app/ and they'll get resolved; resources
                                            // external to our app like jhb_ui partials and images, must be copied into
                                            // app/ manually
            'open',                         // launch our app
            'watch'                         // watch specified files for modifications
        ]);
    });

    grunt.registerTask('dev', [
      'shell:bowerlink:angular-gooii'
    ]);

    grunt.registerTask('test', [
        'clean:server',
        'concurrent:test',
        'autoprefixer',
        'connect:test',
        'karma'
    ]);

    var baseBuild = [
        'coffee',           // 01) compile coffee script files to .tmp/[original path]/[original filename].js
        'compass:dist',     // 02) compile sass files to css
        'useminPrepare',    // 03) scan index.html for <!-- build:js and build:css --> style comment blocks
        'concat',           // 04) runs concat using the configuration dynamically generated by the useminPrepare task
                            //     to merge all bower_components into .tmp/concat/scripts/vendor.js and all angular js
                            //     application js files into .tmp/concat/scripts/scripts.js
        'autoprefixer',     // 05) tidies up any redundant browser vendor prefixes in the css files generated by compass
        'ngAnnotate',       // 06) ensures any injectables in our angular code are safe from minification
        'cssmin',           // 07) minify css files (dynamically generated by useminPrepare task) - input: .tmp/ (see index.html code block) output: dist/
        'bless:dist',       // 08) split the output css files from cssmin into 'chunks' that IE can handle
        'uglify',           // 09) minify js files (dynamically generated by useminPrepare task)
        'rev',              // 10) revision js files to avoid caching (the bless task takes care of cache busting css files)
        'copy:dist',        // 11) copy static resources i.e., app/index.html and app/ images & fonts
        'usemin',           // 12) updates index.html file to reference new css and js files generated by previous grunt tasks
        'htmlmin'           // 13) targets all html partials, minifies and then copies them over to the dist folder; this
                            //     includes a modified version of index.html which should now target the minified, concatenated
                            //     and cached busted js and css resources

    ];

    var buildSteps = function (environment, useRsync, checkout) {
        var steps = [];
        // checkout relevant git branch (matches environment)
        //
        if(checkout) {
            steps.push('gitcheckout:' + environment);
        }
        if(environment == 'production') {

        }
        else {

        }
        // clear dist folder
        //
        steps.push('clean:dist');

        // replace AppConfig file placeholders with env specific settings
        // and copy into place
        //
        steps.push('replace:config_' + environment);

        // additional build steps
        //
        var build = steps.concat(baseBuild);
        // push rsync grunt task if required
        //
        if(useRsync) {
            build.push('rsync:' + environment);
        }
        return build;
    };

    var stagingNow = function() {
      var steps = ['clean:dist', 'replace:config_staging'];
      var build = steps.concat(baseBuild);
      build.push('replace:preload_staging');
      return build;
    };

    var productionNow = function() {
      var steps = ['clean:dist', 'replace:config_production'];
      var build = steps.concat(baseBuild);
      build.push('replace:preload_production');
      build.push('clean:production_html');
      return build;
    };

    grunt.registerTask('staging'        , buildSteps('staging'      , false, true));
    grunt.registerTask('production'     , buildSteps('production'   , false, true));
    grunt.registerTask('preproduction'  , buildSteps('preproduction', false, true));
    grunt.registerTask('stageBuild'     , buildSteps('staging'      , false, true));
    // hmmm any hints? :)
    //
    grunt.registerTask('productionAsIs' , productionNow());
    grunt.registerTask('stagingAsIs'    , stagingNow());

    grunt.registerTask('default', [
        'newer:jshint',
        'test',
        'production'
    ]);
};
