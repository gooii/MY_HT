# Controller for a <nav:item ...> Element
#
class NavItemController
  # Configure dependency injection
  #
  @$inject: ['$scope', '$location', 'rx', 'LoggerService']
  constructor: ($scope, $location, rx, logFactory) ->
    @_$scope              = $scope
    @_$location           = $location
    @_rx                  = rx
    @_observables         = {}

    # initialise logger
    #
    @_log = logFactory.getLogger('controller.NavItem')

    # initialise controller
    #
    @_init()

  _init: ->
    @_initScope()
    @_initEvent()
    @_bindEvent()

  # initialise any publicly accessible properties
  #
  _initProps: ->
    @isChild        = false
    @active         = false
    @hasIcon        = angular.isDefined(@_$scope.icon)
    @hasIconCaption = angular.isDefined(@_$scope.iconCaption)

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
    # done: bindEvent
    #
    return

  #############################################################################
  # Public functions                                                          #
  #############################################################################

  getItemUrl: (view) =>
    return @_$scope.href if (angular.isDefined(@_$scope.href))
    return ''            if (!angular.isDefined(view))
    # default
    #
    return view

  getItemTarget: () =>
    return @_$scope.target if angular.isDefined(@_$scope.target) else '_self'

  isActive: (viewLocation) =>
    @_$scope.active = viewLocation is @_$location.path()
    # done: @_$scope.isActive
    #
    return viewLocation is @_$location.path()


# grab a reference to our main module
#
app = angular.module 'myht'

# Create an instance
app.controller 'NavItemCtrl', NavItemController