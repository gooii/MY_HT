'use strict';

angular.module('myht')
  .constant('appConfig', {
    appName       : 'My Historical Texts'
    bookViewerUrl : '@@bookViewerUrl'
    bookSearchUrl : '@@bookSearchUrl'
    mediaPath     : '@@mediaPath'
    elasticPath   : '@@elasticPath'
    logLevel      : '@@logLevel'
    menu_speed    : 235
});
