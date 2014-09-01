'use strict';

angular.module('myht')
  .constant('configuration', {
    appName       : 'My Historical Texts'
    bookViewerUrl : '@@bookViewerUrl'
    bookSearchUrl : '@@bookSearchUrl'
    mediaPath     : '@@mediaPath'
    elasticPath   : '@@elasticPath'
    logLevel      : '@@logLevel'
  });
