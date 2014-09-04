'use strict'

# declare module for angular-gooii, into which
# the relevant resources get loaded; the files
# get copied into place during grunt's compile
# coffeescript phase
# 
angular.module('gooii', [])

# application wide dependencies
#
app = angular.module('myht', [
  'ngCookies'
  'ngResource'
  'ngSanitize'
  'ngRoute'
  'ui.bootstrap'
  'angular-google-analytics'
  'rx'
  'gooii'
])

# configure service/factory providers
#
app.config ($routeProvider, $locationProvider) ->
  # set old style history mode for browsers that don't support the HTML5
  # history.pushState
  #
  $locationProvider.html5Mode(true)

  # configure routes
  #
  $routeProvider
  .when('/home'           , { templateUrl   : (()             -> return "/partials/home/myht-home.html")                                     , reloadOnSearch: false })
  .when('/:section/:page' , { templateUrl   : (($routeParams) -> return "/partials/#{$routeParams.section}/myht-#{$routeParams.page}.html")  , reloadOnSearch: false })
  .otherwise({
    redirectTo: '/home'
  })

# configure services at runtime; here's also a good place to put some
# convenience stuff on $rootScope if need be
#
app.run (configuration) ->
