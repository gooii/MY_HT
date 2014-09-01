module.exports = function (grunt) {

    var port            = 9001;
    var livereload_port = 35810;

    // PROXY CONFIG
    var proxyServer = 'myht.gummii.co.uk';
    var proxyPaths  = ['/elasticsearch', '/elasticsearch2', '/media'];

    // TEMP PROXY OVERRIDE WHILST DH2 GETS BOUNCED
    //
    // proxyServer = '130.88.120.139'

    // MIDDLEWARE
    var proxySnippet = require('grunt-connect-proxy/lib/utils').proxyRequest;
    var mountFolder = function (connect, dir) {
        return connect.static(require('path').resolve(dir));
    };

    var _ = require('lodash');

    // mod rewrite
    var fileTypes = ['html','png','gif','jpg','js','css','woff','ttf','svg'];
    var modRewrite = require('connect-modrewrite');
    // ['!/elasticsearch|/media|\\.html|\\.png|\\.gif|\\.jpg|\\.js|\\.css|\\.woff|\\.ttf|\\.svg$ /index.html']
    var rewriteRule = '!';
    rewriteRule += proxyPaths.join('|');
    rewriteRule += '|\\.' + fileTypes.join('|\\.');
    rewriteRule += '$ /index.html';

    // Configure proxies
    var proxies = [];
    _.each(proxyPaths, function (path) {
        proxies.push({
            context: path,
            host: proxyServer,
            xforward: true,
            changeOrigin: true
        })
    });

    var config = {
        options: {
            port: port,
            // Change this to '0.0.0.0' to access the server from outside.
            hostname: '0.0.0.0'
        },
        proxies: proxies,
        livereload: {
            options: {
                livereload: livereload_port,
                middleware: function (connect) {
                    return [
                        modRewrite([rewriteRule]),
                        proxySnippet,
                        // trigger livereload whenever the contents of the .tmp folder changes
                        mountFolder(connect, '.tmp'),
                        // same for the app folder
                        mountFolder(connect, 'app'),
                    ];
                }
            }
        },
        test: {
            options: {
                port: (port + 1),
                base: [
                    '.tmp',
                    'test',
                    'app'
                ]
            }
        },
        dist: {
            options: {
                base: 'dist'
            }
        }
    }
    return config;
};
