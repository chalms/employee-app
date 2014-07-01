App.ApiModel = Backbone.Model.extend
  resourceKey: 'api'

  parse: (response) ->
    if response[@resourceKey()] then response[@resourceKey()] else response

  fetch : (options) ->
    options = options || {}

    if !options.force && @collectionName && Metrics.Data[@collectionName].get(@id)
      @attributes = Metrics.Data[@collectionName].get(@id).attributes
      if options.success
        options.success(@, {}, {})
    else
      #custom error to look for 401 and log user out automatically
      originalError = if options.error then options.error else null
      newError = (model, xhr, options) ->
        if xhr.status == 401
          Metrics.unauthorized()
        else if originalError
          originalError(model, xhr, options)
      options.error = newError

      return Backbone.Model.prototype.fetch.call(this, options)

  save: (attributes, options) ->
    options = options || {}
    if typeof(@validate) == 'undefined' || (attributes.responseText = @validate(attributes, options)) == undefined
      options.url = (if typeof @url == 'function' then @url() else @url) if @url
      options.urlRoot = (if typeof @urlRoot == 'function' then @urlRoot() else @urlRoot) if @urlRoot
      method = if @isNew() then 'create' else 'update'

      modelAttributes = {}
      modelAttributes[@resourceKey()] = attributes
      model = new Backbone.Model modelAttributes

      model.set options.extraProperties if options.extraProperties
      #custom error to look for 401 and log user out automatically
      originalError = if options.error then options.error else null
      newError = (model, xhr, options) ->
        if xhr.status == 401
          Metrics.unauthorized()
        else if originalError
          originalError(model, xhr, options)
      options.error = newError


      originalSuccess = if options.success then options.success else null
      newSuccess = (model, response, responseOptions) =>
        model = @parse(model)
        if @collectionName
          Metrics.Data[@collectionName].set(model, {remove: false})
        originalSuccess(model,response,responseOptions) if originalSuccess
      options.success = newSuccess

      Backbone.sync(method, model, options)
    else
      if options.error
        options.error(attributes, attributes.responseText, {})
      return false

  apiCall: (path, data, returnTo, type, opts) ->
    opts || = {}
    Metrics.modal.show()
    # may need to set header here for auth token
    if $.isFunction(@url)
      url= @url()+path
    else
      url= @url+path
    $.ajax
      type: type
      url : url
      data: JSON.stringify(data) #make sure we are sending good json
      dataType: 'json' #json response
      contentType: 'application/json' #sending json
      
      success: (data, textStatus, jqXHR ) ->
        if opts['success']
          Metrics.modal.hide()
          opts['success'](data, textStatus, jqXHR)
        else if returnTo && opts['redirect']
          window.location.href = returnTo
        else if returnTo
          Metrics.Routers.appRouter.navigate '/', {trigger: false}
          Metrics.Routers.appRouter.navigate returnTo, {trigger: true}
        else
          Metrics.modal.hide()
      error: (data, textStatus, jqXHR ) ->
        Metrics.modal.hide()
        Metrics.showAlert 'Something went wrong!'

  apiGet: (path, data, returnTo, opts) ->
    @apiCall(path, data, returnTo, 'GET', opts)

  apiPut: (path, data, returnTo, opts) ->
    @apiCall(path, data, returnTo, 'PUT', opts)

  apiPost: (path, data, returnTo, opts) ->
    @apiCall(path, data, returnTo, 'POST', opts)

,
  attributeLabel: (attr) ->
    if (typeof @attributeLabels != 'undefined' && @attributeLabels[attr]) then @attributeLabels[attr] else Metrics.Helpers.humanize(attr)


