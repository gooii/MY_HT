# Root controller for Search app - Possibly inject UserProfile service here?
#
class AppController
  # Configure dependency injection
  #
  @$inject: ['$rootScope', '$scope', 'rx', 'myhtApplicationModelStateService', 'LoggerService']

  constructor: ($rootScope, $scope, rx, myht$appModelState, logFactory) ->
    @_$rootScope          = $rootScope
    @_$scope              = $scope
    @_rx                  = rx
    @_myht$appModelState  = myht$appModelState
    @_observables         = {}
    @_state               = @_myht$appModelState.retrieve()
    @_userProfile         =
      avatar: "/images/test/avatars/sunny.png"
      name  : "John Doe"

    # initialise logger
    #
    @_log = logFactory.getLogger('controller.App')
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

  # initialise any application specific $scope'd stuff
  #
  _initScope: ->

    return

  # create observables
  #
  _initEvent: () ->
    # route update events
    #
    @_observables.routeUpdate = @_rx.Observable.create (observer) =>
      @_$rootScope.$on '$routeUpdate', () => observer.onNext()
      # done: @rx.Observable.create
      #
      return

    # route change events
    #
    @_observables.routeChange = @_rx.Observable.create (observer) =>
      @_$rootScope.$on '$routeChangeSuccess', () => observer.onNext()
      # done: @rx.Observable.create
      #
      return

    return

  # subscribe to observables
  #
  _bindEvent: ->
    # wire up observable to persist state when anyone makes any modification
    #
    @_rx.Observable.create (observer) =>
      # pass function to $watch as first param which returns the object we
      # want to monitor, second parameter is our usual function invoked by
      # the watcher when it detects a change in which we simply invoke the
      # Observers onNext method, final parameter states whether to perform
      # a deep watch on the object returned by the first parameter
      #
      @_$scope.$watch( (() => return @state()), ((newValue, oldValue) => observer.onNext({newValue: newValue, oldValue: oldValue})), true)
      # done
      #
      return
    .filter (data) =>
      # if the new and old values are identical do not emit anything
      #
      return data.newValue isnt data.oldValue
    .map (data) =>
      # project the new value only from this point
      #
      return data.newValue
    .subscribe (model) =>
      # persist the new application model
      #
      @_myht$appModelState.persist model
      # done: .subscribe
      #
      return

    # done: bindEvent
    #
    return

  #############################################################################
  # Public functions                                                          #
  #############################################################################

  observables: () =>
    return @_observables

  userProfile: (userProfile) =>
    # assign the new user profile if one is provided
    #
    @_userProfile = angular.copy userProfile if angular.isDefined userProfile
    # return the private userProfile instance
    #
    return @_userProfile

  state: (state) =>
    # assign the new user profile if one is provided
    #
    @_state = angular.copy state if angular.isDefined state
    # return the private userProfile instance
    #
    return @_state

  # toggle side menu visibility
  #
  toggleSideMenuHidden: () =>
    # toggle state
    #
    @state().ui.sideMenu.isHidden = !@state().ui.sideMenu.isHidden
    # done: toggleSideMenu
    #
    return

  toggleSideMenuMinified: () =>
    # toggle state
    #
    @state().ui.sideMenu.isMinified = !@state().ui.sideMenu.isMinified
    # done: toggleSideMenu
    #
    return

# grab a reference to our main module
#
app = angular.module 'myht'

# Create an instance
app.controller 'myhtAppCtrl', AppController