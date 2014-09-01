module.exports = {
    html: 'app/index.html',
    options: {
        dest: 'dist',
        flow: {
            html: {
                steps: {
                    css: ['cssmin'],
                    js: ['concat', 'uglifyjs']
                },
                post: {}
            }
        }
    }
};