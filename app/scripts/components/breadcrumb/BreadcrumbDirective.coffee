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
    _initScope()
    _bindEvent()
    # done: init
    #
    return

  _initScope: () ->
    # breadcrumb trail used by our template to render out LI elements
    #
    @_$scope.breadcrumbs = []
    # done: _initScope
    #
    return

  _bindEvent: () ->
    @_myht$ribbon.navItemObservable
    # start with the services current breadcrumb
    #
    .startWith(@_myht$ribbon.currentBreadcrumb)
    # subscribe to subsequent updates
    #
    .subscribe (breadcrumbs) =>
      @_$scope.breadcrumbs = breadcrumbs
      # done: subscribe
      #
      return
    # done: _bindEvent
    #
    return

# grab reference to main application module
#
app = angular.module 'myht'

# create an instance
#
app.directive 'breadcrumb', (MyhtRibbonService, LoggerService) ->
  return {
    restrict    : 'AE'
    replace     : true
    scope       : { }
    template    : """<ol class="breadcrumb"><li data-ng-repeat="crumb in breadcrumbs">{{crumb}}</li></ol>"""
    link        : ($scope, elm, attr) ->
      new BreadcrumbDirective($scope, elm, attr, MyhtRibbonService, LoggerService)
  }