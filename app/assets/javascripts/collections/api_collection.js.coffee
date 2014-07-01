App.ApiCollection = Backbone.Collection.extend
  resourceKey: -> 'api_collection'
  fetchCount: 0
  paginate: false
  fetchPage: 1
  originalModels: []

  parse: (response) ->
    response[@resourceKey()]

  fetch : (options) ->
    options = options || {}

    #custom error to look for 401 and log user out automatically
    originalError = if options.error then options.error else null
    newError = (collection, response, options) ->
      if response.status == 401
        Metrics.unauthorized()
      else if originalError
        originalError(collection, response, options)
    options.error = newError

    if @paginate
      originalSuccess = if options.success then options.success else null
      newSuccess = (collection, response, responseOptions) =>
        if collection.length != 0
          if @parent
            @parent.add(@models)
            @parent.fetchPage += 1

          @fetchPage += 1
          options.success = originalSuccess

          console.log "original Success"
          console.log originalSuccess

          clone = @clone()
          clone.parent = @

          if @parent
            clone.parent = @parent

          clone.fetchPage = @fetchPage
          clone.fetch(options)

        originalSuccess(collection,response,responseOptions) if originalSuccess

      options.success = newSuccess

    return Backbone.Collection.prototype.fetch.call(this, options)

  fetchIfNotfetched: (options) ->
    options = options || {}

    if @fetchCount == 0
      @fetchCount += 1
      @fetch options
    else if options.success
      options.success(@)

  url: ->
    if @paginate
      return @baseUrl + '?page=' + (@fetchPage)
    @baseUrl

