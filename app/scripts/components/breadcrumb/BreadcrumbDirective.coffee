class BreadcrumbDirective

  constructor: ($scope, elm, attr, myht$ribbon, $loggerFactory) ->
    @_$scope      = $scope
    @_elm         = elm
    @_attr        = attr
    @_myht$ribbon = myht$ribbon
    @_log         = $loggerFactory.getLogger('directive.breadcrumb')

    @init()

    @_log.info "Created"

  init: =>
    @_initScope()
    @_bindEvent()
    # done: init
    #
    return

  _initScope: () ->
    # breadcrumb trail used by our template to render out LI elements
    #
    @_$scope.breadcrumbs = @_myht$ribbon.currentBreadcrumb
    # done: _initScope
    #
    return

  _bindEvent: () ->
    # done: _bindEvent
    #
    return

# grab reference to main application module
#
app = angular.module 'myht'

# create an instance
#
app.directive 'breadcrumb', (myhtRibbonService, LoggerService) ->
  return {
    restrict    : 'AE'
    replace     : true
    scope       : { }
    template    : """<ol class="breadcrumb"><li data-ng-repeat="crumb in breadcrumbs">{{crumb}}</li></ol>"""
    link        : ($scope, elm, attr) ->
      new BreadcrumbDirective($scope, elm, attr, myhtRibbonService, LoggerService)
  }