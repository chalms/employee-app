  class Web.Views.Projects extends Backbone.View
  el: '#projects'
  container: '#projects-list'
  template: JST['projects/projects']
  projects: {}

  initialize: ->
    @collection.bind 'reset', @render, @
    @collection.bind 'add', @addProject, @

  addProject: (project) ->
    @render()
    view = new Web.Views.ProjectLineItem({ model: project })
    $(@el).find(@container).append(view.render().el)
    @

  switch: (data) ->
   if @projects[data.get('id')] then @projects[data.get('id')].model = data else projects[data.get('id')] = new Web.Views.Project(model: data)

  render: ->
    $(@el).html(@template())
    @collection.each (project) =>
      view = new Web.Views.ProjectLineItem({ model: project })
      $(@el).find(@container).append(view.render().el)
    @


