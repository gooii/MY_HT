require('coffee-script').register();

exports.config = {

    specs: [
        './test/e2e/**/*e2e.coffee'
    ],

    baseUrl: 'http://localhost:9001'
};