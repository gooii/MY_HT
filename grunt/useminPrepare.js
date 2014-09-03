module.exports = {
    html: 'app/index.html',
    options: {
        dest: 'dist',
        flow: {
            html: {
                steps: {
                    css         : ['cssmin'],               // minifies any css resources in <!-- script --> blocks inside main index.html (updates references)
                    js          : ['concat', 'uglifyjs'],   // concatenates and minifies javascript sources inside <!-- build:js --> script blocks
                    smartcss    : ['concat'],
                    smartjs     : ['concat']
                },
                post: {}
            }
        }
    }
};