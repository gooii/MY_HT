module.exports = {
    html: ['dist/{,*/}*.html'],
    options: {
        assetsDirs: ['dist'],
        blockReplacements: {
            smartcss: function(block) {
                return '<link rel="stylesheet" type="text/css" media="screen" href="' + block.dest + '">';
            },
            smartjs: function(block) {
                return '<script src="' + block.dest + '"></script>';
            }
        }
    }
};