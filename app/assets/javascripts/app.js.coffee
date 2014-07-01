window.App = {}

window.Metrics =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  Helpers: {}
  Data: {}

  initialize: ->
    console.log "initializing routes"
    Metrics.Routers.appRouter = new Metrics.Routers.AppRouter()
    Metrics.launch()

  launch: ->
    console.log "launching app"
    Metrics.Data.user = new Metrics.Models.User()
    Metrics.setUser()
    console.log "user set"
    Backbone.history.start
      pushState: (typeof window.history.pushState != 'undefined')

  showDialogError: (errorMessage, defaultMessage) ->
    $('#showDialogError').remove()
    $('#dialog-body').prepend('<div id="showDialogError" class="alert alert-danger">' + errorMessage + '</div>')

  showError: (errorObject, defaultMessage) ->
    #mg: Converted to array of error strings to match server, don't need this anymore
    # if $.inArray("errors", Metrics.Helpers.objKeys(errorObject)) >= 0
    #   Metrics.showAlert Metrics.Helpers.errorObjectToString(errorObject)
    # else
    Metrics.showAlert defaultMessage

  showAlert: (errorMessage) ->
    showAlertDialog = new Metrics.Views.ShowAlertDialog
      errorMessage: errorMessage

    animatedPopup = new App.DialogView
      view: showAlertDialog

    animatedPopup.show()

  showConfirm: (options) ->
    options = options || {}

    title = if options.title then options.title else 'Application Confirm?'
    message = if options.message then options.message else ''
    okCallback = if options.ok then options.ok else null
    cancelCallback = if options.cancel then options.cancel else null
    showAlertDialog = new Metrics.Views.ShowConfirmDialog
      title: title
      message: message
      okCallback: okCallback
      cancelCallback: cancelCallback
    title: title

    animatedPopup = new App.DialogView
      view: showAlertDialog

    animatedPopup.show()

  showPrompt: (options) ->
    options = options || {}
    message = if options.message then options.message else ''
    submessage = if options.submessage then options.submessage else null
    okCallback = if options.ok then options.ok else null
    cancelCallback = if options.cancel then options.cancel else null
    showAlertDialog = new Metrics.Views.ShowPromptDialog
      message: message
      submessage: submessage
      okCallback: okCallback
      cancelCallback: cancelCallback

    title = if options.title then options.title else 'Application Confirm?'
    animatedPopup = new App.DialogView
      title: title
      animate: true
      view: showAlertDialog
      buttons:
        left:
          null

    animatedPopup.show()

Metrics.unauthorized = ->
  window.location = '/unauthorized'

Metrics.nativeAndroidVersion = '0.9.3'
