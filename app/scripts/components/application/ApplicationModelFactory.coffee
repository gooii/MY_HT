# A class which models an Elastic Search Query
#
class ApplicationModel
  # create instance
  #
  constructor: () ->
    @ui =
      sideMenu: {
        isHidden: false
        isMinified: false
      }

class ApplicationModelFactory
  # singleton factory constructor
  #
  constructor: () ->
    # return the QueryModel constructor; this allows anyone using our
    # factory as an injectable dependency to new(ify) instances
    #
    return ApplicationModel

# grab reference to main application module
#
app = angular.module 'myht'

# create an instance
#
app.factory 'myhtApplicationModel', ApplicationModelFactory