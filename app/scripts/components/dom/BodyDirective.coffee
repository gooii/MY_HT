class BodyDirective

  constructor: ($scope, elm, attr, configuration, $window, $location, $timeout, $loggerFactory) ->
    @_$scope    = $scope
    @_elm       = elm
    @_attr      = attr
    @_config    = configuration
    @_$window   = $window
    @_$location = $location
    @_$timeout  = $timeout
    @_log       = $loggerFactory.getLogger('directive.myhtBody')

    @init()

    @_log.info "Created"

  init: ->
    # ensure that any empty a tags when clicked prevent the default browser event from occruring
    #
    @_elm.on('click', 'a[data-ng-href=""]', (e) -> e.preventDefault())

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
app.directive 'myhtBody', (configuration, $window, $location, $timeout, LoggerService) ->
  return {
    restrict: 'A',
    link: ($scope, elm, attr) ->
      new BodyDirective($scope, elm, attr, configuration, $window, $location, $timeout, LoggerService)
    }