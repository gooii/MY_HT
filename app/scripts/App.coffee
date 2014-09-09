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
app.config ($routeProvider, $locationProvider, $provide) ->
  # use the injected provider service to create a 'configuration' provider - this
  # is a requirement for the gooii logger service we're pulling in; we'll base it
  # off of out AppConfig constant, but could just as easily return a subset of it
  # relevant to the properties required by the LoggerService
  #
  $provide.provider 'configuration', () =>
    return {
      $get: (appConfig) ->
        return appConfig
    }

  # set old style history mode for browsers that don't support the HTML5
  # history.pushState
  #
  $locationProvider.html5Mode(true)

  # configure routes
  #
  $routeProvider
  .when('/home/dashboard' , { templateUrl   : (()             -> return "/partials/home/myht-dashboard.html")                                , reloadOnSearch: false })
  .when('/:section/:page' , { templateUrl   : (($routeParams) -> return "/partials/#{$routeParams.section}/myht-#{$routeParams.page}.html")  , reloadOnSearch: false })
  .otherwise({
    redirectTo: '/home/dashboard'
  })

# configure services at runtime; here's also a good place to put some
# convenience stuff on $rootScope if need be
#
app.run (appConfig) ->
