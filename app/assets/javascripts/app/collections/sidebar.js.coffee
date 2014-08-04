class Web.Collections.Sidebar extends Backbone.Collection
  url: '/links'
  models: Web.Models.Link

  initialize: (args) ->
    super(args)
    setDefaults()
    setSelected()

  setDefaults: ->
    @models.add(new Web.Models.Link(model: {name: 'projects', text: 'Projects' href: '/projects'}))
    @models.add(new Web.Models.Link(model: {name: 'employees', text: 'Employees', href: '/employees'}))
    @models.add(new Web.Models.Link(model: {name: 'clients', text: 'Clients', href: '/clients'}))

  setSelected: ->
    try
      @models._.where('name', @.get('main')).first.set('selected', true)
    catch (err)
      console.log(err)
    defaultSelected()

  defaultSelected: ->
    none = true
    def = null

    @models.each (link) ->
      if link.get('selected')
        none = false
        break
      else
        if link.get('name') is 'projects'
          def = link

    if none and def is not null
      def.set('selected', true)



