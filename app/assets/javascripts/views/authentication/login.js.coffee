class Metrics.Views.Login extends Marionette.ItemView
  template: JST['templates/authentication/login']
  className: 'container'

  events:
    "click #submit": "submit"

  initialize: ->
    @model.on "change", @render

  submit: (e) ->
    e.stopPropagation()
    e.preventDefault()

    queryString = @$("form").serialize()
    console.log "#{queryString}"

    $.ajax
      url: 'sessions/new'
      data: queryString
      error: (jqXHR, textStatus, errorThrown) ->
          $(@).find('input').each -> @reset()
          console.log "Failure"
          # $ ->
