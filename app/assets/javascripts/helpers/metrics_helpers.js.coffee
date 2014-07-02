String.prototype.containsUpperCase = ->
  @match(/[A-Z]/)

String.prototype.capitalize = ->
  @charAt(0).toUpperCase() + @slice(1)

String.prototype.startsWith = (str) ->
  @indexOf(str) == 0

String.prototype.endsWith = (suffix) ->
  @indexOf(suffix, @length - suffix.length) != -1

String.prototype.contains = (str) ->
  @indexOf(str) != -1

#for IE8
Object.keys = Object.keys || ->
  hasOwnProperty = Object.prototype.hasOwnProperty
  hasDontEnumBug = !{toString:null}.propertyIsEnumerable("toString")
  DontEnums = ['toString','toLocaleString','valueOf','hasOwnProperty','isPrototypeOf','propertyIsEnumerable','constructor']
  DontEnumsLength = DontEnums.length

  return (o) ->
    if typeof o != "object" && typeof o != "function" || o == null
      throw new TypeError "Object.keys called on a non-object"

    result = []
    for name in o
      if hasOwnProperty.call(o, name)
        result.push name

    if hasDontEnumBug
      for i in [0..DontEnumsLength]
        if hasOwnProperty.call(o, DontEnums[i])
          result.push DontEnums[i]

    return result

Number.prototype.roundedToTwoDecimals = ->
  parseFloat(@toFixed(2))

Metrics.Helpers =

  subdomain: ->
    window.location.host.split('.')[0]

  isSupplyApp: ->
    @subdomain().indexOf('supply') >= 0

  isEstimatingApp: ->
    !@isSupplyApp()

  isAndroid: ->
    navigator.userAgent.indexOf('Android') >= 0
  isAndroidApp: (version) ->
    if navigator.userAgent.indexOf('Android-App') >= 0
      if typeof version != 'undefined'
        androidVersion = if navigator.userAgent.split('-').length == 3 then navigator.userAgent.split('-')[2] else null
        #its not the version if the useragent doesn't have a version
        return false if androidVersion == null
        #its not the version if the useragent is smaller than version being checked
        return false if typeof version != 'undefined' && androidVersion != null && @compareVersions(androidVersion, version) < 0

      return true

    return false

  isiPad: ->
    navigator.userAgent.indexOf('iPad') >= 0
  isiPhone: ->
    navigator.userAgent.indexOf('iPhone') >= 0
  isiOS: ->
    @isiPad() || @isiPhone()
  isMobile: ->
    @isAndroid() || @isiPad() || @isiPhone()
  isWeb: ->
    !@isMobile()

  compareVersions: (v1,v2) ->
    #assume . separation e.g. 1.0.1.2
    v1Parts = v1.split('.')
    v2Parts = v2.split('.')
    cmp = 0 #assume equal at first

    if v1Parts.length > v2Parts.length
      shorter = v2Parts
      longer = v1Parts
    else
      shorter = v1Parts
      longer = v2Parts

    for i in [0...shorter.length] when cmp == 0
      if parseInt(v1Parts[i]) != parseInt(v2Parts[i])
        cmp = 1 if parseInt(v1Parts[i]) > parseInt(v2Parts[i])
        cmp = -1 if parseInt(v1Parts[i]) < parseInt(v2Parts[i])

    #if they're still equal make sure the longer one isn't all remaining 0's
    if cmp == 0
      for j in [i...longer.length]
        if parseInt(longer[j]) != 0
          cmp = 1 if v1Parts.length > v2Parts.length
          cmp = -1 if v1Parts.length < v2Parts.length

    return cmp


  keyForValue: (obj,searchValue) ->
    for key,value of obj
      return Metrics.Helpers.humanize(key) if value == searchValue

    return null

  humanize: (property) ->
    return '' if property == null
    property.replace(/_/g, ' ').replace(/(\w+)/g, (match) ->
      return match.charAt(0).toUpperCase() + match.slice(1)
    )

  modernizeInputs: ->
    if(!Modernizr.input.placeholder)
      $('[placeholder]').focus( ->
        input = $(this)

        if (input.val() == input.attr('placeholder'))
          input.val('')
          input.removeClass('placeholder')

      ).blur( ->
        input = $(this)
        if (input.attr('type') == 'text' && (input.val() == '' || input.val() == input.attr('placeholder')))
          input.addClass('placeholder')
          input.val(input.attr('placeholder'))

      ).blur()

      $('[placeholder]').parents('form').submit( ->
        $(this).find('[placeholder]').each( ->
          input = $(this)
          if (input.val() == input.attr('placeholder'))
            input.val('')

        )
      )

  #TODO should take a date not a string
  formatDate: (dateStr) ->
    if typeof dateStr == 'undefined' || dateStr == null
      datrStr = ''
    else if dateStr.charAt(dateStr.length - 1) == 'Z'
      dateStr = dateStr.slice(0,-1)
    else if dateStr.match(/^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}-\d{2}:\d{2}$/)
      dateStr = dateStr.slice(0,dateStr.lastIndexOf('-'))

    d = Globalize.parseDate(dateStr)

    Globalize.format(d, 'D')

  serializeObjectToObject: (serializeObject) ->
    obj = {}
    for item in serializeObject
      obj[item.name] = item.value
    return obj

  queryStringToObject: (queryString) ->
    if queryString[0] == '?'
      queryString = queryString[1..-1]
    obj = {}
    parts = queryString.split('&')
    for part in parts
      keyValue = part.split('=')
      obj[keyValue[0]] = this.getParameterByNameFrom(keyValue[0], "?"+queryString)

    return obj

  objectToQueryString: (obj) ->
    str = ''
    for key in Object.keys(obj)
      str += '&' + key + '=' + obj[key]

    return str.substring(1)

  getParameterByNameFrom: (name, from) ->
    name = name.replace(/[\[]/, "\\\[").replace(/[\]]/, "\\\]")
    regexS = "[\\?&]" + name + "=([^&#]*)"
    regex = new RegExp(regexS)
    results = regex.exec(from)

    if(results == null) then "" else decodeURIComponent(results[1].replace(/\+/g, " "))

  getParameterByName: (name) ->
    this.getParameterByNameFrom(name, window.location.search)

  formatPercent: (n) ->
    num = if isNaN(parseFloat(n)) then 0 else parseFloat(n)
    (num).toFixed(0)+'%'

  formatMoney: (n) ->
    num = if isNaN(parseFloat(n)) then 0 else parseFloat(n)
    "$"+(num).toFixed(2)

  objKeys: (obj) ->
    Object.keys(obj)

  isEmpty: (obj) ->
    $.isEmptyObject(obj)

  validEmails: (emails) ->
    for email in emails.split(',')
      if this.validEmail(email) == false
        return false
    true

  validEmail: (email) ->
    re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/
    re.test email

  filterPhone: (phone) ->
    if @validPhone(phone) then phone.replace(/[^0-9]/g, '') else null

  validPhone: (phone) ->
    filtered_phone = phone.replace(/[^0-9]/g, '')
    re = /^[0-9]{10,11}$/
    re.test filtered_phone

  SHA1: (msg) ->
    rotate_left = (n, s) ->
      t4 = (n << s) | (n >>> (32 - s))
      t4
    lsb_hex = (val) ->
      str = ""
      i = undefined
      vh = undefined
      vl = undefined
      i = 0
      while i <= 6
        vh = (val >>> (i * 4 + 4)) & 0x0f
        vl = (val >>> (i * 4)) & 0x0f
        str += vh.toString(16) + vl.toString(16)
        i += 2
      str
    cvt_hex = (val) ->
      str = ""
      i = undefined
      v = undefined
      i = 7
      while i >= 0
        v = (val >>> (i * 4)) & 0x0f
        str += v.toString(16)
        i--
      str
    Utf8Encode = (string) ->
      string = string.replace(/\r\n/g, "\n")
      utftext = ""
      n = 0

      while n < string.length
        c = string.charCodeAt(n)
        if c < 128
          utftext += String.fromCharCode(c)
        else if (c > 127) and (c < 2048)
          utftext += String.fromCharCode((c >> 6) | 192)
          utftext += String.fromCharCode((c & 63) | 128)
        else
          utftext += String.fromCharCode((c >> 12) | 224)
          utftext += String.fromCharCode(((c >> 6) & 63) | 128)
          utftext += String.fromCharCode((c & 63) | 128)
        n++
      utftext
    blockstart = undefined
    i = undefined
    j = undefined
    W = new Array(80)
    H0 = 0x67452301
    H1 = 0xEFCDAB89
    H2 = 0x98BADCFE
    H3 = 0x10325476
    H4 = 0xC3D2E1F0
    A = undefined
    B = undefined
    C = undefined
    D = undefined
    E = undefined
    temp = undefined
    msg = Utf8Encode(msg)
    msg_len = msg.length
    word_array = new Array()
    i = 0
    while i < msg_len - 3
      j = msg.charCodeAt(i) << 24 | msg.charCodeAt(i + 1) << 16 | msg.charCodeAt(i + 2) << 8 | msg.charCodeAt(i + 3)
      word_array.push j
      i += 4
    switch msg_len % 4
      when 0
        i = 0x080000000
      when 1
        i = msg.charCodeAt(msg_len - 1) << 24 | 0x0800000
      when 2
        i = msg.charCodeAt(msg_len - 2) << 24 | msg.charCodeAt(msg_len - 1) << 16 | 0x08000
      when 3
        i = msg.charCodeAt(msg_len - 3) << 24 | msg.charCodeAt(msg_len - 2) << 16 | msg.charCodeAt(msg_len - 1) << 8 | 0x80
    word_array.push i
    word_array.push 0  until (word_array.length % 16) is 14
    word_array.push msg_len >>> 29
    word_array.push (msg_len << 3) & 0x0ffffffff
    blockstart = 0
    while blockstart < word_array.length
      i = 0
      while i < 16
        W[i] = word_array[blockstart + i]
        i++
      i = 16
      while i <= 79
        W[i] = rotate_left(W[i - 3] ^ W[i - 8] ^ W[i - 14] ^ W[i - 16], 1)
        i++
      A = H0
      B = H1
      C = H2
      D = H3
      E = H4
      i = 0
      while i <= 19
        temp = (rotate_left(A, 5) + ((B & C) | (~B & D)) + E + W[i] + 0x5A827999) & 0x0ffffffff
        E = D
        D = C
        C = rotate_left(B, 30)
        B = A
        A = temp
        i++
      i = 20
      while i <= 39
        temp = (rotate_left(A, 5) + (B ^ C ^ D) + E + W[i] + 0x6ED9EBA1) & 0x0ffffffff
        E = D
        D = C
        C = rotate_left(B, 30)
        B = A
        A = temp
        i++
      i = 40
      while i <= 59
        temp = (rotate_left(A, 5) + ((B & C) | (B & D) | (C & D)) + E + W[i] + 0x8F1BBCDC) & 0x0ffffffff
        E = D
        D = C
        C = rotate_left(B, 30)
        B = A
        A = temp
        i++
      i = 60
      while i <= 79
        temp = (rotate_left(A, 5) + (B ^ C ^ D) + E + W[i] + 0xCA62C1D6) & 0x0ffffffff
        E = D
        D = C
        C = rotate_left(B, 30)
        B = A
        A = temp
        i++
      H0 = (H0 + A) & 0x0ffffffff
      H1 = (H1 + B) & 0x0ffffffff
      H2 = (H2 + C) & 0x0ffffffff
      H3 = (H3 + D) & 0x0ffffffff
      H4 = (H4 + E) & 0x0ffffffff
      blockstart += 16
    temp = cvt_hex(H0) + cvt_hex(H1) + cvt_hex(H2) + cvt_hex(H3) + cvt_hex(H4)
    temp.toLowerCase()
