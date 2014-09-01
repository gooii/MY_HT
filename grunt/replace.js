var grunt   = require('grunt');
var _       = require('lodash');

// The 'src' is the service template which will have the template strings replaced by
// the environment specific config
// The 'dest' is where to write the final angular service file
var files = [{
    expand  : true,
    flatten : true,
    src     : ['./config/AppConfig.coffee'],
    dest    : 'app/scripts/components/constants/'
  }
];

// Where to read the environment specific configs
var envDir = './config/environments/';

// Which environments are in use
var environments = ['development', 'staging', 'preproduction', 'production'];

var includes = {
  development   : {data:'dev.js'    , src:'./app/index.html'    , dest:'.tmp/index.html'},
  staging       : {data:'staging.js', src:'./dist/index.html'   , dest:'dist/index.html'},
  production    : {data:'shib.php'  , src:'./dist/index.html'   , dest:'dist/index.php' },
  preproduction : {data:'shib.php'  , src:'./dist/index.html'   , dest:'dist/index.php' }
};

module.exports = {};

_.each(environments, function (env) {
  module.exports['config_' + env] = {
    options: {
      patterns: [
        {
          json: grunt.file.readJSON(envDir + env + '.json')
        }
      ]
    },
    files: files
  };
});
