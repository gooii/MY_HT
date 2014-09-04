class NavigationDirective

  constructor: ($scope, elm, attr, configuration, $window, $location, $timeout, $loggerFactory) ->
    @_$scope    = $scope
    @_elm       = elm
    @_attr      = attr
    @_config    = configuration
    @_$window   = $window
    @_$location = $location
    @_$timeout  = $timeout
    @_log       = $loggerFactory.getLogger('directive.navigation')

    @init()

    @_log.info "Created"

  init: =>
    # enable/decorate menu navigation items
    #
    @_jarvismenu(@_elm.first(), {
      accordion : true,
      speed     : @_config.menu_speed,
      closedSign: '<em class="fa fa-plus-square-o"></em>',
      openedSign: '<em class="fa fa-minus-square-o"></em>'
    })

    # SLIMSCROLL FOR NAV
    #
    @_elm.slimScroll({ height: '100%' }) if $.fn.slimScroll

    # allow access to this navigation item
    #
    @_$scope.getElement = () -> return @_elm

    # done: init
    #
    return

  # decorate menu items - this is lifted straight from the sample App.js
  #
  _jarvismenu: ($elm, options) ->
    defaults =
      accordion   : 'true'
      speed       : 200
      closedSign  : '[+]'
      openedSign  : '[-]'

    # extend our default options with those provided
    #
    opts = angular.extend(defaults, options)

    # add a mark [+] to a multilevel menu
    #
    $elm.find("li").each () ->
      if ($(this).find("ul").size() isnt 0)
        # add the multilevel sign next to the link
        #
        $(this).find("a:first").append("<b class='collapse-sign'>" + opts.closedSign + "</b>")

        # avoid jumping to the top of the page when the href is an '#'
        #
        if ($(this).find("a:first").attr('href') is "#")
          $(this).find("a:first").click () -> return false

    # open active level
    #
    $elm.find("li.active").each () ->
      $(this).parents("ul").slideDown(opts.speed)
      $(this).parents("ul").parent("li").find("b:first").html(opts.openedSign)
      $(this).parents("ul").parent("li").addClass("open")


    $elm.find("li a").click () ->
      if ($(this).parent().find("ul").size() isnt 0)
        if (opts.accordion)
          # do nothing when the list is open
          #
          if (!$(this).parent().find("ul").is(':visible'))
            parents = $(this).parent().parents("ul");
            visible = $(this).find("ul:visible");
            visible.each (visibleIndex) ->
              close = true
              parents.each (parentIndex) ->
                if (parents[parentIndex] == visible[visibleIndex])
                  close = false
                  return false
              if (close)
                if ($(this).parent().find("ul") != visible[visibleIndex])
                  $(visible[visibleIndex]).slideUp(opts.speed, () ->
                    $(this).parent("li").find("b:first").html(opts.closedSign)
                    $(this).parent("li").removeClass("open"))

        if ($(this).parent().find("ul:first").is(":visible") and !$(this).parent().find("ul:first").hasClass("active"))
          $(this).parent().find("ul:first").slideUp(opts.speed, () ->
            $(this).parent("li").removeClass("open")
            $(this).parent("li").find("b:first").delay(opts.speed).html(opts.closedSign))
        else
          $(this).parent().find("ul:first").slideDown(opts.speed, () ->
            $(this).parent("li").addClass("open")
            $(this).parent("li").find("b:first").delay(opts.speed).html(opts.openedSign))

# grab reference to main application module
#
app = angular.module 'myht'

# create an instance
#
app.directive 'navigation', (configuration, $window, $location, $timeout, LoggerService) ->
  return {
    restrict    : 'AE'
    transclude  : true
    replace     : true
    scope       : {}
    template    : '<nav><ul data-ng-transclude=""></ul></nav>'
    controller  : ($scope) ->
      # empty function for the time being until we move this out
      # to its own controller
      #
      return
    link        : ($scope, elm, attr) ->
      new NavigationDirective($scope, elm, attr, configuration, $window, $location, $timeout, LoggerService)
  }