class NavGroupDirective

  constructor: ($scope, elm, attr, configuration, $window, $location, $timeout, $loggerFactory) ->
    @_$scope    = $scope
    @_elm       = elm
    @_attr      = attr
    @_config    = configuration
    @_$window   = $window
    @_$location = $location
    @_$timeout  = $timeout
    @_log       = $loggerFactory.getLogger('directive.navGroup')

    @init()

    @_log.info "Created"

  init: =>
    # done: init
    #
    return

# grab reference to main application module
#
app = angular.module 'myht'

# create an instance
#
app.directive 'navGroup', (configuration, $window, $location, $timeout, LoggerService) ->
  return {
    restrict  : 'AE',
    controller: 'NavGroupCtrl',
    transclude: true,
    replace   : true,
    scope     : {
      icon        : '@'
      title       : '@'
      iconCaption : '@'
      active      : '=?' # not seen this binding before ... two-way optional?
    }
    link : ($scope, elm, attr) ->
      new NavGroupDirective($scope, elm, attr, configuration, $window, $location, $timeout, LoggerService)
    template: """
      <li data-ng-class="{active: active}">
        <a href="">
          <i data-ng-if="hasIcon" class="{{ icon }}"><em data-ng-if="hasIconCaption"> {{ iconCaption }} </em></i>
          <span class="menu-item-parent" data-localize="{{ title }}">{{ title }}</span>
        </a>
        <ul data-ng-transclude="" class="nav-group"></ul>
      </li>
    """
  }