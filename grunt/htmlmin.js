module.exports = {
    dist: {
        options: {
            collapseWhitespace: true,
            collapseBooleanAttributes: true,
            removeCommentsFromCDATA: true,
            removeOptionalTags: true
        },
        files: [{
            /* copy search app partials to dist folder */
            expand: true,
            cwd: 'app',
            src: ['partials/**/*.html'],
            dest: 'dist'
        }]
    }
};