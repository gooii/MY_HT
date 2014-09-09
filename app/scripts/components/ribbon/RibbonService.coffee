class RibbonService
  # Configure dependency injection
  #
  @$inject: ['LoggerService', '$timeout']
  constructor: (jisc$logger, $timeout) ->
    @_$timeout    = $timeout
    # initialise logger
    #
    @_logger = jisc$logger.getLogger('service.RibbonService')
    @_logger.log('create service')
    # init public properties
    #
    @currentBreadcrumb  = []
    # initialise
    #
    @_init()

  # intialise public observable which emits an item each time our internal
  # breadcrumb reference changes
  #
  _init: () ->
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
    @_$timeout () =>
      angular.copy breadcrumb, @currentBreadcrumb
      # done: @_$timeout
      #
      return
    # done: updateBreadcrumb
    #
    return

app = angular.module 'myht'

app.service 'myhtRibbonService', RibbonService
