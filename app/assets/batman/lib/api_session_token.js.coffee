$ ->
  tokenValue = $("meta[name='csrf-token']").attr("content")
  $.ajaxSetup headers:
    "X-CSRF-Token": tokenValue
  return

ApiSessionToken = ->
ApiSessionToken::token = null
ApiSessionToken::ttl = 0
ApiSessionToken::user = null
ApiSessionToken::isAlive = ->
  @get("ttl") > 0

ApiSessionToken::_this = ApiSessionToken
ApiSessionToken::hasToken = ->
  token = undefined
  token = undefined
  token = @get("token")
  if token and (typeof token is "string") and (token.length > 0)
    true
  else
    false

ApiSessionToken::isValid = ->
  @get("hasToken") and @get("isAlive")

ApiSessionToken::needsRefresh = ->
  @get("ttl") <= 10

ApiSessionToken::init = ->
  @scheduleTtlDecrement()

ApiSessionToken::decrementTtl = ->
  @decrementProperty "ttl"  if @get("isAlive")
  @scheduleTtlDecrement()

ApiSessionToken::scheduleTtlDecrement = ->
  callback ->
    decrementTtl()

  setTimeout callback, 1000

ApiSessionToken::refresh = ->
  @acquire this

ApiSessionToken::acquire = (token) ->
  credentials = undefined
  password = undefined
  username = undefined
  credentials = undefined
  password = undefined
  username = undefined
  token or (token = @create())
  credentials = {}
  username = token.get("user.username")
  password = token.get("user.password")
  credentials.token = token.get("token")  if token.get("hasToken")
  if username and password
    credentials.username = username
    credentials.password = password
  $.ajax
    dataType: "json"
    data: credentials
    url: "http://localhost:3000/api/sessions"
    type: "POST"
    success: (data, status, xhr) ->
      token.set "token", data.api_session_token.token
      token.set "ttl", data.api_session_token.ttl
      token.get("user").authenticated()  if username and password

    error: (xhr, status, error) ->
      token.set "error", "" + status + ": " + error
  token

new ApiSessionToken()