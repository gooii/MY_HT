class ApplicationModelStateService
  # Static property for retrieval and storeage of layout cookie
  #
  @cookieId: 'myht.state'

  # Configure dependency injection
  @$inject: ['$window', '$http', '$q', '$cookieStore', 'LoggerService', 'myht.ApplicationModel']

  constructor: (@$window, @$http, @$q, @$cookieStore, jisc$logger, @ApplicationModel) ->
    # initialise logger
    #
    @log = jisc$logger.getLogger('service.ApplicationModelState')
    @log.log('create service')

  # Retrieves the cookie responsible for storing application state locally rather
  # than in the browser URL
  retrieve: ->
    # attempt to retreive the layout cookie
    #
    model = @$cookieStore.get ApplicationModelStateService.cookieId

    # Setup application cookie object; apply defaults if neccessary
    if not model
      # create the layout cookie with defaults
      #
      model = new @ApplicationModel()

      # Store the cookie
      #
      @persist(model)
    else
      # control model instance
      #
      ctrl = new @ApplicationModel()
      # process all control model properties, and if not already
      # present in our deserialized model, assign them with each
      # default value
      #
      _.forOwn ctrl, (val, key) ->
        model[key] = val if not _.has(model, key)

      # clean up serialized model (shallow) and remove properties
      # that no longer exist
      #
      _.forOwn model, (val, key) ->
        # remove this property if it is no longer relevant
        #
        delete model[key] if not _.has(ctrl, key)
        # done
        #
        return
      # serialize it
      #
      @persist(model)

    # Return the retrieved layout state
    #
    return model

  # Invoked each time our appCookie stored on $scope is modified
  #
  persist:(model) ->
    # store the model using our cookie id
    #
    @$cookieStore.put(ApplicationModelStateService.cookieId, model)
    # done: persist
    #
    return

app = angular.module 'myht'

app.service 'myht.ApplicationModelStateService', ApplicationModelStateService
