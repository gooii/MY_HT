# The <aside> tag defines some content aside from the content it is placed in.
#
# The aside content should be related to the surrounding content
#
class AsidePanelDirective
  constructor: ($scope, elm, attr, configuration, $window, $location, $timeout, $loggerFactory) ->
    @_$scope    = $scope
    @_elm       = elm
    @_attr      = attr
    @_config    = configuration
    @_$window   = $window
    @_$location = $location
    @_$timeout  = $timeout
    @_log       = $loggerFactory.getLogger('directive.sidePanel')

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
app.directive 'aside', (configuration, $window, $location, $timeout, LoggerService) ->
  return {
    restrict      : 'E',
    transclude    : true,
    replace       : false,
    requires      : "aside"
    templateUrl   : "/partials/components/myht-left-panel.html"
    link          : ($scope, elm, attr) ->
      new AsidePanelDirective($scope, elm, attr, configuration, $window, $location, $timeout, LoggerService)

  }