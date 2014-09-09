class NavItemDirective

  constructor: ($scope, elm, attr, parentCtrls, configuration, $window, $location, $timeout, $loggerFactory, myht$ribbon) ->
    @_$scope      = $scope
    @_elm         = elm
    @_attr        = attr
    @_parentCtrls = parentCtrls
    @_config      = configuration
    @_$window     = $window
    @_$location   = $location
    @_$timeout    = $timeout
    @_myht$ribbon = myht$ribbon
    @_log         = $loggerFactory.getLogger('directive.navItem')

    @init()

  init: =>
    @_navCtrl       = @_parentCtrls[0]
    @_navGroupCtrl  = @_parentCtrls[1]

    @_initScope()
    @_bindEvent()

    # done: init
    #
    return

  _initScope: () ->
    # note that we reference the controller for this directive instance
    # using the controllerAs property 'ctrl'
    #
    @_$scope.openParents    = @_$scope.ctrl.isActive(@_$scope.view)
    @_$scope.isChild        = angular.isDefined(@_navGroupCtrl)
    @_$scope.setBreadcrumb  = () =>
      crumbs = []
      crumbs.push(@_$scope.title)
      # get parent menus
      #
      @_elm.parents('nav li').each (index, element) =>
        el      = angular.element(element)
        parent  = el.find('.menu-item-parent:eq(0)')
        crumbs.push(parent.data('localize').trim())
        if (@_$scope.openParents)
          # open menu on first load
          #
          parent.trigger('click')
      # this should be only fired upon first load so let's set this to false now
      #
      @_$scope.openParents = false
      # update breadcrumb trail
      #
      @_myht$ribbon.updateBreadcrumb(crumbs)
    # done: initScope
    #
    return

  _bindEvent: () ->
    # keep an eye on the active state of this menu item
    #
    @_$scope.$watch 'active', (newVal) =>
      if (newVal)
        # set the nav item active
        #
        @_navGroupCtrl.setActive(true) if (angular.isDefined(@_navGroupCtrl))
        # set the doc title to that of this menu item
        #
        @_$window.document.title = @_$scope.title
        # update breadcrumb trail
        #
        @_$scope.setBreadcrumb()
      else if (angular.isDefined(@_navGroupCtrl))
        # deselect this menu item and its containing group if we're part of one
        #
        @_navGroupCtrl.setActive(false)
    # handle click events on the navigation item (specifically the a tag it wraps)
    #
    @_elm.on 'click', 'a[href!="#"]', () ->
      # just remove various css class names if we're being viewed in a mobile
      # device
      #
      if ($('body').hasClass('mobile-view-activated'))
        $('body').removeClass('hidden-menu')
        $('html').removeClass("hidden-menu-mobile-lock")
    # done: bindEvent
    #
    return

# grab reference to main application module
#
app = angular.module 'myht'

# create an instance; this directive relies on parent directive 'myhtNavigation' which MUST
# be present further up the DOM hierarchy; it also depends on the directive: 'myhtNavGroup'
# but this parent depdency is optional and only applies if the nav item is wrapped inside a
# <myht-nav:group> element
#
# by requiring these directives we get access to their controllers and hence scope even if
# we're isolating the $scope as we are in this case
#
app.directive 'navItem', (configuration, $window, $location, $timeout, LoggerService, myhtRibbonService) ->
  return {
    require       : ['^navPanel', '^?navGroup'],
    restrict      : 'AE',
    transclude    : true,
    replace       : true,
    controller    : 'NavItemCtrl'
    controllerAs  : 'ctrl'
    scope         : {
      title       : '@',
      view        : '@',
      icon        : '@',
      iconCaption : '@',
      href        : '@',
      target      : '@'
    }
    link: ($scope, elm, attr, parentCtrls) ->
      new NavItemDirective($scope, elm, attr, parentCtrls, configuration, $window, $location, $timeout, LoggerService, myhtRibbonService)
    template: """
				<li data-ng-class="{active: ctrl.isActive(view)}">
					<a data-ng-href="{{ ctrl.getItemUrl(view) }}" title="{{ title }}">
						<i data-ng-if="icon" class="{{ icon }}"><em data-ng-if="iconCaption"> {{ iconCaption }} </em></i>
						<span ng-class="{'menu-item-parent': !ctrl.isChild}" data-localize="{{ title }}"> {{ title }} </span>
						<span data-ng-transclude=""></span>
					</a>
				</li>
    """
  }