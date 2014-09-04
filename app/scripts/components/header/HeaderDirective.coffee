class HeaderDirective

  constructor: ($scope, elm, attr, configuration, $window, $location, $timeout, $loggerFactory) ->
    @_$scope    = $scope
    @_elm       = elm
    @_attr      = attr
    @_config    = configuration
    @_$window   = $window
    @_$location = $location
    @_$timeout  = $timeout
    @_log       = $loggerFactory.getLogger('directive.myhtHeader')

    @init()

    @_log.info "Created"

  init: ->
    # done: init
    #
    return

# grab reference to main application module
#
app = angular.module 'myht'

# create an instance
#
app.directive 'myhtHeader', (configuration, $window, $location, $timeout, LoggerService) ->
  return {
    restrict: 'E',
    templateUrl: '/partials/components/myht-header.html'
    link: ($scope, elm, attr) ->
      new HeaderDirective($scope, elm, attr, configuration, $window, $location, $timeout, LoggerService)
    }