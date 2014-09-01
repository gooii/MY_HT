module.exports = {
    options: {
        livereload: '<%= connect.livereload.options.livereload %>'
    },
    html: {
        files: [
            // reload if the index.html or any other root html file changes
            //
            'app/{,*/}*.html',
            // reload if any partials change
            //
            'app/partials/**/{,*/}*.html'
        ]
    },
    compass: {
        files: [
            // trigger compass tasks if either our search app sass or
            // the jhb_ui bower_component sass files changes
            //
            'app/styles/{,*/}*.{scss,sass}',
            'app/bower_components/jisc_ui/app/styles/{,*/}*.{scss,sass}'
        ],
        tasks: ['compass:server', 'bless:local', 'autoprefixer']
    },
    coffee: {
        // recompile coffee script for our search app and jhb_ui module
        //
        files: ['app/scripts/**/{,*/}*.coffee', 'app/bower_components/jisc_ui/app/scripts/shared/**/{,*/}*.coffee','app/bower_components/angular-gooii/src/**/{,*/}*.coffee'],
        tasks: ['coffee']
    },
    gruntfile: {
        files: ['Gruntfile.js']
    }
};