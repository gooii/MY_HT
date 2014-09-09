class LayoutService
  # Configure dependency injection
  #
  @$inject: ['LoggerService', '$timeout', 'rx', '$window']
  constructor: (jisc$logger, $timeout, rx, $window) ->
    @_$timeout    = $timeout
    @_$window     = $window
    @_Rx          = rx
    @_observables = {}
    # initialise logger
    #
    @_logger = jisc$logger.getLogger('service.myhtLayoutService')
    @_logger.log('create service')

    # initialise
    #
    @_init()

  # intialise public observable which emits an item each time our internal
  # breadcrumb reference changes
  #
  _init: () ->
    @_observables.windowSize = @_Rx.Observable.create (observer) =>
      $window = $(@_$window)
      $window.resize () -> observer.onNext( {
        width : $window.width()
        height: $window.height()
      })
    .throttle(250)
    .share()
    # done: _init
    #
    return

  # public API
  #
  observables: () =>
    return @_observables

app = angular.module 'myht'

app.service 'myhtLayoutService', LayoutService
