class RibbonDirective

  constructor: ($scope, elm, attr, configuration, $window, $location, $timeout, $loggerFactory) ->
    @_$scope    = $scope
    @_elm       = elm
    @_attr      = attr
    @_config    = configuration
    @_$window   = $window
    @_$location = $location
    @_$timeout  = $timeout
    @_log       = $loggerFactory.getLogger('directive.ribbon')

    @init()

    @_log.info "Created"

  init: =>

    # done: init
    #
    return

# grab reference to main application module
#
app = angular.module 'myht'

# create an instance
#
app.directive 'ribbon', (appConfig, $window, $location, $timeout, LoggerService) ->
  return {
    restrict    : 'A'
    scope       : { }
    templateUrl : "/partials/components/myht-ribbon.html"
    link        : ($scope, elm, attr) ->
      new RibbonDirective($scope, elm, attr, appConfig, $window, $location, $timeout, LoggerService)
  }