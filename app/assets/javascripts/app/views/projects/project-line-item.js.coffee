class Web.Views.ProjectLineItem extends Backbone.Marionette.ItemView
    template: JST['/projects/project-line-item']

    events:
      'click' : @showProject

    showProject: ->
      Web.commands.execute('switch', @model)
      # Web.vent()
      # Web.Layouts.Main.setContentView(@model)

