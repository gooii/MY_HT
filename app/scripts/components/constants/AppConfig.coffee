'use strict';

angular.module('myht')
  .constant('configuration', {
    appName       : 'My Historical Texts'
    bookViewerUrl : 'http://localhost:9000'
    bookSearchUrl : 'http://localhost:9001'
    mediaPath     : '/media'
    elasticPath   : '/elasticsearch2'
    logLevel      : 'all'
    menu_speed    : 235
});
