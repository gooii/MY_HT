class BodyDirective

  constructor: ($scope, elm, attr, appConfig, $window, $location, $timeout, $loggerFactory) ->
    @_$scope      = $scope
    @_elm         = elm
    @_attr        = attr
    @_appConfig   = appConfig
    @_$window     = $window
    @_$location   = $location
    @_$timeout    = $timeout
    @_log         = $loggerFactory.getLogger('directive.body')

    @init()

    @_log.info "Created"

  init: ->
    # create 'body' scope
    #
    @_$scope.body = {}

    # ensure that any empty a tags when clicked prevent the default browser event from occruring
    #
    @_elm.on('click', 'a[data-ng-href=""], a[data-ng-href="#"]', (e) -> e.preventDefault())

    # DETECT MOBILE DEVICES
    #
    # Description: Detects mobile device - if any of the listed device is detected
    # a class is applied to body, (so far this is covering most hand held devices)
    #
    ismobile = (/iphone|ipad|ipod|android|blackberry|mini|windows\sce|palm/i.test(@_$window.navigator.userAgent.toLowerCase()))

    if (!ismobile)
      # desktop
      #
      @_elm.addClass("desktop-detected")
    else
      # mobile
      @_elm.addClass("mobile-detected")

    # done: init
    #
    return

# grab reference to main application module
#
app = angular.module 'myht'

# create an instance
#
app.directive 'body', (appConfig, $window, $location, $timeout, LoggerService) ->
  return {
    restrict: 'E'
    link: ($scope, elm, attr) ->
      new BodyDirective($scope, elm, attr, appConfig, $window, $location, $timeout, LoggerService)
    }