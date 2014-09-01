module.exports = {
    compile: {
        options: {
            sourceMap: false
        },
        files: [{
            /* compile all myht app source coffee script files */
            expand: true,
            cwd: 'app',
            src: 'scripts/**/*.coffee',
            dest:'.tmp',
            ext:'.js'
        },
        {
            /* do the same for all the gooii 'shared' coffeescript files */
            expand: true,
            cwd: 'app/bower_components/angular-gooii/src',
            src: '**/*.coffee',
            /* our app will expect to pull these resources in from /scripts/components/gooii */
            dest: '.tmp/scripts/components/gooii',
            ext:'.js'
        }]
    }
};