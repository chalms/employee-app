class App.Routers.Chat extends App.Router

  routes: {
    '/' : @index,
    '/chats' : @chats
  },

  layout: null

  initialize: (url, params) ->
    @auth = (redis.get(url.inc) or redis.put(url.inc, params['auth_token'])
    @layout = url.done() ? @routes['/'](params) : @routes[url.inc](url, params)

  chats: (url, params) ->
    new App.Routers.Chats(url, params)

  index: (params) ->
    new App.Layouts.App(params)