class Router extends Backbone.Marionette.Router

  routes: {
    '/' : @,
    '/chats' : @chats
  },

  initialize: (url, params) ->
    @auth = (redis.get(url) or redis.put(url, params['auth_token']) if (!@auth)
    @router = url.done() ? @routes['/'](params) : @routes[url.inc](url, params)
    router.render(params)

  renderNavbar: (params) ->
    new App.Routers.Subnav(@)
    new App.Routers.SideBar(@)

  chats: (url, params) ->
    new App.View.Chat(url.inc, par)
