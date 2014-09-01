'use strict';

# declare module for angular-gooii, into which
# the relevant resources get loaded; the files
# get copied into place during grunt's compile
# coffeescript phase
# 
angular.module('gooii', [])

# application wide dependencies
#
app = angular.module('myht', [
  'gooii'
  'ngCookies'
  'ngResource'
  'ngSanitize'
  'ngRoute'
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
    .when('/home', { templateUrl: '/partials/home/home.html', controller: 'HomeCtrl', controllerAs: 'home', reloadOnSearch: false })

  # redirect to /home if an unrecognised route is entered for the time being
  #
  $routeProvider.otherwise
    redirectTo: () ->
      '/home'

# configure services at runtime; here's also a good place to put some
# convenience stuff on $rootScope if need be
#
app.run (configuration) ->
