module.exports = {
    dist: {
        files: [{
            dot: true,
            src: [
                '.tmp',
                'dist/*',
                '!dist/.git*'
            ]
        }]
    },
    server: {
        files: [{
            dot: true,
            src: [
                /* always clean out .tmp folder */
                '.tmp'
            ]
        }]
    },
    production_html: {
      files:[{
        src:['dist/index.html']
      }]
    }
};