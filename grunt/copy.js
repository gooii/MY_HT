module.exports = {
    dist: {
        files: [{
            /* copy across index.html and any image resource from myht app */
            expand: true,
            dot: true,
            cwd: 'app',
            dest: 'dist',
            src: [
                '*.html',
                'images/{,*/}/**/*.*'
            ]
        }]
    },
    server: {
        /* when running a local node webserver we need to manually copy in
         * any external dependencies e.g., any static resources from bower
         * linked projects:-
         */
        files: []
    }
};