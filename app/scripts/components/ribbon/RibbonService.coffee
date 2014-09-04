class RibbonService
  # Static property for retrieval and storeage of layout cookie
  #
  @cookieId: 'myht.state'

  # Configure dependency injection
  #
  @$inject: ['$rootScope', 'rx', 'LoggerService']
  constructor: ($rootScope, rx, jisc$logger) ->
    @_$rootScope  = $rootScope
    @_rx          = rx
    # initialise logger
    #
    @_logger = jisc$logger.getLogger('service.RibbonService')
    @_logger.log('create service')
    # init public properties
    #
    @currentBreadcrumb  = []
    @navItemObservable  = null
    # initialise
    #
    @_init()

  # intialise public observable which emits an item each time our internal
  # breadcrumb reference changes
  #
  _init: () ->
    @navItemObservable = @_rx.Observable.create (observer) =>
      @_$rootScope.$watch( (() -> return @currentBreadcrumb), ((newVal, oldVal) -> observer.onNext({newVal: newVal, oldVal: oldVal})), false )
    .filter (data) ->
      return data.newValue isnt data.oldValue
    .map (data) ->
      return data.newValue
    # share a single subscription rather than creating one subscription (stream) per
    # observer
    #
    .share()

    # done: _init
    #
    return

  # public methods
  #
  updateBreadcrumb: (crumbs) =>
    # default push 'Home' as the first item
    #
    crumbs.push('Home')
    # reorder supplied breadcrumbs
    #
    breadcrumb = crumbs.reverse()
    # refresh internal ref
    #
    @currentBreadcrumb = breadcrumb
    # done: updateBreadcrumb
    #
    return

app = angular.module 'myht'

app.service 'myhtRibbonService', RibbonService
