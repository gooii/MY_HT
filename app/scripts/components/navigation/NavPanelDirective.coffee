class NavPanelDirective

  constructor: ($scope, elm, attr, configuration, $window, $location, $timeout, $loggerFactory, myht$layout) ->
    @_$scope      = $scope
    @_elm         = elm
    @_attr        = attr
    @_config      = configuration
    @_$window     = $window
    @_$location   = $location
    @_myht$layout = myht$layout
    @_$timeout    = $timeout
    @_log         = $loggerFactory.getLogger('directive.navPanel')

    @init()

    @_log.info "Created"

  init: =>
    # enable/decorate menu navigation items
    #
    @_jarvismenu(@_elm.first(), {
      accordion : false,
      speed     : @_config.menu_speed,
      closedSign: '<em class="fa fa-plus-square-o"></em>',
      openedSign: '<em class="fa fa-minus-square-o"></em>'
    })

    # allow access to this navigation item
    #
    @_$scope.getElement = () -> return @_elm

    # listen out for window resize events
    #
    @_myht$layout.observables().windowSize
    .startWith({
        width : $(@_$window).width()
        height: $(@_$window).height()
    })
    .subscribe (size) =>
      # reset slim scroll
      #
      @_elm.parent(".nav-panel-wrapper").height(size.height - 49 - 41)
      # done: subscribe
      #
      return

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
      # done: $elm.find("li").each
      #
      return

    # open active level
    #
    $elm.find("li.active").each () ->
      $(this).parents("ul").slideDown(opts.speed)
      $(this).parents("ul").parent("li").find("b:first").html(opts.openedSign)
      $(this).parents("ul").parent("li").addClass("open")
      # done: $elm.find("li.active").each
      #
      return

    # wire up click events to each li wrapped anchor element
    #
    $elm.find("li a").click () ->
      if ($(this).parent().find("ul").size() isnt 0)
        # if we're in 'accorion' mode, only one nav group may be open; all others
        # get collapsed
        #
        if (opts.accordion)
          # if the parent UL wrapping this A element is already visible
          # do nothing in accorion mode
          #
          if (!$(this).parent().find("ul").is(':visible'))
            # walk up the DOM tree from the clicked A element and collect all
            # parent UL elements
            #
            parents = $(this).parent().parents("ul");
            # grab all visible UL elements within this navigation directive element
            #
            visible = $elm.find("ul:visible");
            # process each visible UL element
            #
            visible.each (visibleIndex) ->
              # default to collapsing this visible UL element
              #
              close = true
              # walk up the DOM tree of parent UL elements
              #
              parents.each (parentIndex) ->
                # bomb out if any ancestor UL element of the clicked A element is
                # already visible (we don't want to collapse it - this is the nav
                # group we're supposed to be revealing)
                #
                if (parents[parentIndex] is visible[visibleIndex])
                  # keep this UL open
                  #
                  close = false
                  # don't process any more parent UL elements
                  #
                  return false
                # done: parents.each
                #
                return

              if (close)
                # this visible UL element needs to be collapsed
                #
                if ($(this).parent().find("ul") isnt visible[visibleIndex])
                  $(visible[visibleIndex]).slideUp(opts.speed, () ->
                    $(this).parent("li").find("b:first").html(opts.closedSign)
                    $(this).parent("li").removeClass("open"))
              # done: visible.each
              #
              return

        if ($(this).parent().find("ul:first").is(":visible") and !$(this).parent().find("ul:first").hasClass("active"))
          $(this).parent().find("ul:first").slideUp(opts.speed, () ->
            $(this).parent("li").removeClass("open")
            $(this).parent("li").find("b:first").delay(opts.speed).html(opts.closedSign))
        else
          $(this).parent().find("ul:first").slideDown(opts.speed, () ->
            $(this).parent("li").addClass("open")
            $(this).parent("li").find("b:first").delay(opts.speed).html(opts.openedSign))

      # done: $elm.find("li a").click
      #
      return

    # done: _jarvismenu
    #
    return

# grab reference to main application module
#
app = angular.module 'myht'

# create an instance
#
app.directive 'navPanel', (configuration, $window, $location, $timeout, LoggerService, myhtLayoutService) ->
  return {
    restrict    : 'AE'
    transclude  : true
    replace     : true
    scope       : {}
    template    : '<nav><ul data-ng-transclude="" class="navigation"></ul></nav>'
    controller  : ($scope) ->
      # empty function for the time being until we move this out
      # to its own controller
      #
      return
    link : ($scope, elm, attr) ->
      new NavPanelDirective($scope, elm, attr, configuration, $window, $location, $timeout, LoggerService, myhtLayoutService)
  }