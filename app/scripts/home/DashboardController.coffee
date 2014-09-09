# Root controller for Home section of the App.
#
class DashboardController
  # Configure dependency injection
  #
  @$inject: ['$rootScope', '$scope', 'rx', 'LoggerService']
  constructor: ($rootScope, $scope, rx, logFactory) ->
    @_$rootScope          = $rootScope
    @_$scope              = $scope
    @_rx                  = rx
    @_observables         = {}

    # initialise logger
    #
    @_log = logFactory.getLogger('controller.DashboardCtrl')
    @_log.info "Created"

    # initialise controller
    #
    @_init()

  _init: ->
    @_initProps()
    @_initScope()
    @_initEvent()
    @_bindEvent()

  # initialise any publicly accessible properties
  #
  _initProps: ->
    # done: _initProps
    #
    return

  # initialise any application specific $scope'd stuff
  #
  _initScope: ->

    # done: _initScope
    #
    return

  # create observables
  #
  _initEvent: () ->
    # done: _initEvent
    #
    return

  # subscribe to observables
  #
  _bindEvent: ->

    # done: _bindEvent
    #
    return

  #############################################################################
  # Public functions                                                          #
  #############################################################################

  # getter allowing access to the Rx Observables specific to this controller
  #
  observables: () =>
    return @_observables

# grab a reference to our main module
#
app = angular.module 'myht'

# Create an instance
app.controller 'DashboardCtrl', DashboardController